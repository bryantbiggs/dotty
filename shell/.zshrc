# Sourced for INTERACTIVE shells only.
#
# PATH and environment live in .zshenv so that non-interactive shells get them
# too. Only things a human at a prompt needs belong here: completions, prompt,
# aliases, and hooks. If something is missing from a script, it belongs in
# .zshenv, not here.

# ==============================================================================
# Node
#
# nvm is lazy loaded. Sourcing nvm.sh eagerly cost roughly 520ms of every shell
# startup, over half the total, even when no node version was active. These
# shims defer the load until first use and then delete themselves so the real
# commands take over. NVM_DIR is set in .zshenv.
# ==============================================================================
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
# rebuilt the completion dump on every startup, roughly 250ms. bashcompinit
# requires compinit to have already run, so it comes after the oh-my-zsh source.
#
# ZSH_THEME is deliberately unset, which is what gives the stock zsh prompt
# (%m%#). oh-my-zsh only sources a theme when ZSH_THEME is non-empty. With no
# theme and no plugins, oh-my-zsh contributes only its lib defaults: history
# options, key bindings, directory aliases, and completion styling.
# ==============================================================================
export ZSH="${HOME}/.oh-my-zsh"
plugins=()
ZSH_DISABLE_COMPFIX=true
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="bg=#ffff00,fg=#000000"

source "$ZSH/oh-my-zsh.sh"

autoload -U +X bashcompinit && bashcompinit

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
  [[ -f "${HOME}/.config/broot/launcher/bash/br" ]] && source "${HOME}/.config/broot/launcher/bash/br"
fi
