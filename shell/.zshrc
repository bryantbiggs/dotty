# ==============================================================================
# Platform
#
# Detected once here. Everything platform specific keys off these flags instead
# of repeating the $OSTYPE test inline.
# ==============================================================================
typeset -g OS_MACOS=0 OS_LINUX=0
case "$OSTYPE" in
  darwin*) OS_MACOS=1 ;;
  linux*)  OS_LINUX=1 ;;
esac

# ==============================================================================
# PATH
#
# Built from a clean slate so the result is deterministic regardless of what a
# login shell or a package installer prepended. "typeset -U" keeps the array
# deduplicated, retaining the first (highest precedence) occurrence.
# ==============================================================================
unset PATH
typeset -U path PATH

export PATH="$HOME/.cargo/bin"

if (( OS_MACOS )); then
  # TODO(mac): "$HOME/usr/local/opt/ruby/bin" looks like a typo for
  # "/usr/local/opt/ruby/bin" (Intel brew) or "/opt/homebrew/opt/ruby/bin"
  # (Apple Silicon). Cannot verify from Linux; check during the Mac pass.
  PATH="${HOME}/usr/local/opt/ruby/bin:${PATH}"
  PATH="${PATH}:$(ruby -e 'puts Gem.bindir')"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if (( OS_LINUX )); then
  PATH="/home/linuxbrew/.linuxbrew/bin:${PATH}"
  PATH="/home/linuxbrew/.linuxbrew/sbin:${PATH}"
  PATH="${PATH}:/snap/bin"
fi

# System directories last, so user and package manager tools take precedence.
PATH="${PATH}:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

# uv and rustup installer shim. It is idempotent and guards against double
# entries, so a single call here is enough. This was previously pulled in three
# separate times: here, via .bashrc, and from .zshenv.
. "$HOME/.local/bin/env"

# ==============================================================================
# Go
# ==============================================================================
export GOENV_ROOT="$HOME/.goenv"
if [[ -d "$GOENV_ROOT" ]]; then
  PATH="${GOENV_ROOT}/bin:${PATH}"
  eval "$(goenv init -)"

  # Guarded. When no global version is set, goenv leaves GOROOT and GOPATH
  # empty and an unguarded expansion prepends a bare "/bin" to PATH, which is
  # how this silently broke: "go" resolved to a shim that could not find a
  # toolchain. Set a version with: goenv use <version> --global
  [[ -n "$GOROOT" ]] && PATH="${GOROOT}/bin:${PATH}"
  [[ -n "$GOPATH" ]] && PATH="${PATH}:${GOPATH}/bin"
fi

# ==============================================================================
# Node
#
# nvm is lazy loaded. Sourcing nvm.sh eagerly cost roughly 520ms of every shell
# startup, over half the total, even when no node version was active. These
# shims defer the load until first use and then delete themselves so the real
# commands take over.
# ==============================================================================
export NVM_DIR="$HOME/.nvm"

if (( OS_MACOS )); then
  _nvm_sh="/opt/homebrew/opt/nvm/nvm.sh"
  _nvm_completion="/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
else
  _nvm_sh="/home/linuxbrew/.linuxbrew/opt/nvm/nvm.sh"
  _nvm_completion="/home/linuxbrew/.linuxbrew/opt/nvm/etc/bash_completion.d/nvm"
fi

if [[ -s "$_nvm_sh" ]]; then
  _nvm_load() {
    unset -f nvm node npm npx _nvm_load
    . "$_nvm_sh"
    [[ -s "$_nvm_completion" ]] && . "$_nvm_completion"
  }
  for _c in nvm node npm npx; do
    eval "${_c}() { _nvm_load; ${_c} \"\$@\"; }"
  done
  unset _c
fi

# ==============================================================================
# Completions and prompt
#
# oh-my-zsh runs compinit itself. Calling compinit here as well ran it twice and
# rebuilt the completion dump on every single startup, roughly 250ms. bashcompinit
# requires compinit to have already run, so it comes after the oh-my-zsh source.
#
# Note: ZSH_THEME is deliberately left unset, which is what gives the stock zsh
# prompt (%m%#). oh-my-zsh only sources a theme when ZSH_THEME is non-empty.
# With no theme and no plugins, oh-my-zsh is contributing only its lib defaults
# (history, key bindings, completion styling) and compinit.
# ==============================================================================
export ZSH="$HOME/.oh-my-zsh"
plugins=()
ZSH_DISABLE_COMPFIX=true
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="bg=#ffff00,fg=#000000"

source "$ZSH/oh-my-zsh.sh"

autoload -U +X bashcompinit && bashcompinit

# ==============================================================================
# Environment
# ==============================================================================
export EDITOR='vim'
export LANG=en_US.UTF-8
export TF_PLUGIN_CACHE_DIR="$HOME/.terraform.d/plugin-cache"

if (( OS_MACOS )); then
  # TODO(mac): x86_64 is wrong on Apple Silicon. Verify during the Mac pass.
  export ARCHFLAGS="-arch x86_64"
fi

# ==============================================================================
# Aliases
#
# Pruned against ~/.zsh_history. Aliases with no recorded use were removed:
# tfi tfp tfl tfo, kgs kdp kds, lcd lcf lcsd lcsf, dsclean pyclean jsclean runclean.
# ==============================================================================
alias python='python3'

# cat is aliased to bat, so ocat is the escape hatch to the real thing. This was
# previously written "alias ocat'cat'", which zsh parses as a query for an alias
# named "ocatcat", so ocat never actually existed.
alias cat='bat'
alias ocat='command cat'

# Replaced colorls, a Ruby gem whose shebang broke when the system Ruby moved
# from 3.2 to 3.3. eza is a static binary with no interpreter dependency.
alias lc='eza -la'

# Terraform
alias tf='terraform'
alias tfclean='find . | grep -E "(\.terraform|\.terraform.lock.hcl|\.tfsec|\.terraform.tfstate*)" | xargs rm -rf'

# Kubernetes
alias k='kubectl'
alias kgp='kubectl get pods'
alias kgn='kubectl get nodes'
alias kdn='kubectl describe nodes'

# Cleanup
alias dclean='docker image prune -a && docker container prune'
alias ghclean='gh run list --limit 100 --json databaseId -q ".[].databaseId" | xargs -IID gh run delete ID'

# Homebrew
if (( OS_MACOS )); then
  alias brewup="brew update; brew outdated; mas upgrade; brew cleanup; brew doctor"
else
  alias brewup="brew update; brew outdated; brew cleanup; brew doctor"
fi

# Claude
alias claude-personal="CLAUDE_CONFIG_DIR=~/.claude-personal claude"
alias claude-clowd="CLAUDE_CONFIG_DIR=~/.claude-clowd-haus claude"

# ==============================================================================
# Hooks
# ==============================================================================
eval "$(direnv hook zsh)"

if (( OS_MACOS )); then
  eval "$(starship init zsh)"
  # Was hardcoded to /Users/bryantbiggs/...; $HOME is equivalent and portable.
  [[ -f "$HOME/.config/broot/launcher/bash/br" ]] && source "$HOME/.config/broot/launcher/bash/br"
fi
