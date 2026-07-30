# Sourced for EVERY zsh: interactive, non-interactive, login, and script.
#
# Environment belongs here rather than in .zshrc. zsh only sources .zshrc for
# interactive shells, so anything defined there is invisible to a zsh-shebang
# script, to "ssh host <cmd>", and to any tool that spawns "zsh -c". This file
# previously held only the cargo shim, which is why a clean "zsh -c" could not
# find go, terraform, or rg.
#
# Keep this file cheap. It runs on every single zsh invocation.

case "$OSTYPE" in
  darwin*) export OS_MACOS=1 OS_LINUX=0 ;;
  linux*)  export OS_MACOS=0 OS_LINUX=1 ;;
  *)       export OS_MACOS=0 OS_LINUX=0 ;;
esac

source "${HOME}/Documents/dotty/shell/path.zsh"

export EDITOR='vim'
export LANG=en_US.UTF-8
export TF_PLUGIN_CACHE_DIR="${HOME}/.terraform.d/plugin-cache"
export NVM_DIR="${HOME}/.nvm"

if (( OS_MACOS )); then
  # TODO(mac): x86_64 is wrong on Apple Silicon. Verify during the Mac pass.
  export ARCHFLAGS="-arch x86_64"
fi
