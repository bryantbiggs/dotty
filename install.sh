#!/usr/bin/env bash
#
# Idempotent dotfiles installer. Safe to re-run; running it twice changes nothing.
#
# Replaces the previous main.sh, which could not work: it called brew/brew.sh and
# env/macos.sh (neither path exists), it used "rm" on files that may not be there
# so it aborted under any strict mode, and it ended by sourcing ~/.bash_profile on
# a machine whose login shell is zsh.
#
# Two rules this script follows that the old one did not:
#
#   1. Never "rm -rf" a destination directory. The old code/code.sh ran
#      "ln -s <target> ~/.config/Code/User" against a directory that already
#      existed, and ln quietly created the link INSIDE it as User/User rather than
#      replacing it. VS Code config was never actually managed, and dotty's copy
#      sat frozen for two years while the live one moved on. Individual files are
#      linked here, never whole directories.
#
#   2. Anything already in place is moved to a timestamped backup rather than
#      deleted, so a bad run is recoverable.
#
# Usage:
#   ./install.sh                 link dotfiles only (fast, safe, the default)
#   ./install.sh --with-packages also install brew/apt packages (slow)
#   ./install.sh --check         report what would change, modify nothing

set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP="${HOME}/.dotty-backup/$(date +%Y%m%d-%H%M%S)"

WITH_PACKAGES=0
CHECK_ONLY=0
for arg in "$@"; do
  case "$arg" in
    --with-packages) WITH_PACKAGES=1 ;;
    --check)         CHECK_ONLY=1 ;;
    -h|--help)       sed -n '2,30p' "$0" | sed 's/^# \{0,1\}//'; exit 0 ;;
    *) echo "unknown argument: $arg" >&2; exit 1 ;;
  esac
done

case "$OSTYPE" in
  darwin*) OS=macos ;;
  linux*)  OS=linux ;;
  *) echo "unsupported OSTYPE: $OSTYPE" >&2; exit 1 ;;
esac

changed=0
ok()   { printf '  \033[32m✓\033[0m %s\n' "$1"; }
act()  { printf '  \033[33m→\033[0m %s\n' "$1"; changed=$((changed + 1)); }
warn() { printf '  \033[31m!\033[0m %s\n' "$1"; }

# link SRC DEST - idempotent symlink, backing up whatever is already there.
link() {
  local src="$1" dest="$2"

  if [[ ! -e "$src" ]]; then
    warn "source missing, skipped: $src"
    return 0
  fi

  # Compare the literal link target rather than resolving it. BSD and GNU
  # readlink differ on -f, and the literal form is what this script writes.
  if [[ -L "$dest" && "$(readlink "$dest")" == "$src" ]]; then
    ok "${dest/#$HOME/\~}"
    return 0
  fi

  if [[ $CHECK_ONLY -eq 1 ]]; then
    act "would link ${dest/#$HOME/\~} -> ${src/#$DOTFILES/dotty}"
    return 0
  fi

  if [[ -e "$dest" || -L "$dest" ]]; then
    local rel="${dest#"$HOME"/}"
    mkdir -p "$BACKUP/$(dirname "$rel")"
    mv "$dest" "$BACKUP/$rel"
    warn "backed up existing ${dest/#$HOME/\~} to ${BACKUP/#$HOME/\~}/$rel"
  fi

  mkdir -p "$(dirname "$dest")"
  ln -s "$src" "$dest"
  act "${dest/#$HOME/\~} -> ${src/#$DOTFILES/dotty}"
}

echo
echo "dotty installer  (os=$OS, mode=$([[ $CHECK_ONLY -eq 1 ]] && echo check || echo apply))"
echo

echo "shell"
# .zshenv is the important one: zsh reads it for EVERY shell, so PATH and
# environment live there. .zshrc is interactive-only and holds aliases, the
# prompt, and completions. .zprofile exists for macOS, where path_helper runs
# between the two and would otherwise demote our PATH behind the system dirs.
link "$DOTFILES/shell/.zshenv"      "$HOME/.zshenv"
link "$DOTFILES/shell/.zprofile"    "$HOME/.zprofile"
link "$DOTFILES/shell/.zshrc"       "$HOME/.zshrc"
link "$DOTFILES/shell/.bashrc"      "$HOME/.bashrc"
link "$DOTFILES/shell/.bash_profile" "$HOME/.bash_profile"
# path.zsh is sourced by .zshenv and .zprofile by absolute path, not linked.

echo
echo "git"
link "$DOTFILES/git/.gitconfig" "$HOME/.gitconfig"

echo
echo "vscode"
# A single file, deliberately. Linking the whole User directory is what broke
# last time, and it also drags globalStorage and History (hundreds of megabytes
# of runtime state) into the repo working tree.
if [[ "$OS" == macos ]]; then
  VSCODE_USER="$HOME/Library/Application Support/Code/User"
else
  VSCODE_USER="$HOME/.config/Code/User"
fi
if [[ -d "$VSCODE_USER" ]]; then
  link "$DOTFILES/vscode/settings.json" "$VSCODE_USER/settings.json"
else
  warn "VS Code not installed, skipped"
fi

if [[ $WITH_PACKAGES -eq 1 && $CHECK_ONLY -eq 0 ]]; then
  echo
  echo "packages"
  if command -v brew >/dev/null 2>&1; then
    if [[ "$OS" == macos ]]; then
      brew bundle --file="$DOTFILES/macos/brew/Brewfile"
    else
      brew bundle --file="$DOTFILES/linux/Brewfile"
    fi
    act "brew bundle applied"
  else
    warn "brew not installed, skipped"
  fi

  if [[ "$OS" == linux && -f "$DOTFILES/linux/apt-packages.txt" ]]; then
    # shellcheck disable=SC2046
    sudo apt-get install -y $(tr '\n' ' ' < "$DOTFILES/linux/apt-packages.txt")
    act "apt packages applied"
  fi
fi

echo
echo "verify"
for f in .zshenv .zprofile .zshrc .bashrc .bash_profile .gitconfig; do
  if [[ -L "$HOME/$f" ]]; then ok "~/$f linked"; else warn "~/$f NOT linked"; fi
done

# The check that actually matters: a non-interactive zsh must find the toolchain.
# If PATH ever drifts back into .zshrc, this is what catches it.
if command -v zsh >/dev/null 2>&1; then
  missing=""
  for t in cargo go; do
    env -i HOME="$HOME" zsh -c "command -v $t" >/dev/null 2>&1 || missing="$missing $t"
  done
  if [[ -z "$missing" ]]; then
    ok "non-interactive zsh resolves the toolchain"
  else
    warn "non-interactive zsh cannot find:$missing (is PATH in .zshrc instead of .zshenv?)"
  fi
fi

echo
if [[ $CHECK_ONLY -eq 1 ]]; then
  echo "check complete: $changed change(s) pending"
else
  echo "done: $changed change(s)"
  [[ -d "$BACKUP" ]] && echo "backups: ${BACKUP/#$HOME/\~}"
fi
echo
