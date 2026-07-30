# PATH construction.
#
# Sourced from .zshenv, so every shell gets it: interactive, non-interactive,
# login, and script. On macOS it is sourced a second time from .zprofile,
# because path_helper runs between those two files and reorders PATH to put the
# system directories first, which would otherwise demote everything set here.
# Rebuilding is idempotent, so the second pass simply restores the intended order.
#
# Built from a clean slate for determinism. "typeset -U" keeps the array
# deduplicated, retaining the first (highest precedence) occurrence, which is why
# entries are prepended in reverse precedence order below.

unset PATH
typeset -U path PATH

# System directories first, so external commands used further down (brew, ruby,
# goenv) can actually resolve. Everything after this prepends, so these end up
# last in precedence despite being set first.
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

if [[ "$OSTYPE" == linux* ]]; then
  PATH="/snap/bin:${PATH}"
fi

PATH="${HOME}/.cargo/bin:${PATH}"

if [[ "$OSTYPE" == linux* ]]; then
  PATH="/home/linuxbrew/.linuxbrew/bin:${PATH}"
  PATH="/home/linuxbrew/.linuxbrew/sbin:${PATH}"
fi

if [[ "$OSTYPE" == darwin* ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"

  # TODO(mac): the original read "$HOME/usr/local/opt/ruby/bin", which looks like
  # a typo for the absolute path. Verify against the Mac before trusting either.
  [[ -d /opt/homebrew/opt/ruby/bin ]] && PATH="/opt/homebrew/opt/ruby/bin:${PATH}"
  if command -v ruby >/dev/null 2>&1; then
    PATH="${PATH}:$(ruby -e 'puts Gem.bindir')"
  fi
fi

# Go. The shims exec goenv itself, so GOENV_ROOT/bin has to be on PATH or every
# shim fails with "exec: goenv: not found". goenv init costs about 10ms, which is
# affordable here and is what populates GOROOT and GOPATH.
export GOENV_ROOT="${HOME}/.goenv"
if [[ -d "$GOENV_ROOT" ]]; then
  PATH="${GOENV_ROOT}/bin:${PATH}"
  eval "$(goenv init -)"

  # Guarded: with no global version set, goenv leaves these empty and an
  # unguarded expansion prepends a bare "/bin".
  [[ -n "$GOROOT" ]] && PATH="${GOROOT}/bin:${PATH}"
  [[ -n "$GOPATH" ]] && PATH="${PATH}:${GOPATH}/bin"
fi

# rustup and uv installer shims. Both are idempotent and guard against double
# entries, so sourcing them here is safe on the macOS second pass.
[[ -f "${HOME}/.cargo/env" ]] && . "${HOME}/.cargo/env"
[[ -f "${HOME}/.local/bin/env" ]] && . "${HOME}/.local/bin/env"
