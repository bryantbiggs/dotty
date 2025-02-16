# Clear path - clean slate
unset PATH

# Brew coreutils
eval "$(/opt/homebrew/bin/brew shellenv)"

# Add the default directories AFTER the above (+=)
PATH="${PATH}:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

# Golang
export GOENV_ROOT="$HOME/.goenv"
export PATH="$GOENV_ROOT/bin:$PATH"
eval "$(goenv init -)"
export PATH="$GOROOT/bin:$PATH"
export PATH="$PATH:$GOPATH/bin"
export GOPROXY=direct

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# Clean up possible duplicates in path and export
typeset -aU path
export PATH
export MANPATH=$(manpath)

# Misc
alias ocat'cat'
alias cat='bat'
alias python=python3

# Terraform
alias tf='terraform'
alias tfi='terraform init -upgrade=true'
alias tfa='terraform apply --auto-approve'
alias tfp='terraform plan'
alias tfl='terraform state list'
alias tfo='terraform output'

# Clean commands
alias tfclean='find . | grep -E "(\.terraform|\.terraform.lock.hcl|\.terraform.tfstate*)" | xargs rm -rf'
alias dsclean='find . | grep -E "(.DS_Store)" | xargs rm'
alias pyclean='find . | grep -E "(__pycache__|\.pyc|\.pyo$|\.pytest_cache)" | xargs rm -rf'
alias jsclean='find . | grep -E "(node_modules|\.serverless|package-lock.json|yarn.lock|dist)" | xargs rm -rf'
alias dclean='docker image prune -a && docker container prune'
alias runclean='dsclean; pyclean'

# HomeBrew
alias brewup="brew update; brew outdated; mas upgrade; brew cleanup; brew doctor"

# # colorls
# alias lc='colorls -la'
# alias lcd='colorls --dirs -la'
# alias lcf='colorls --files -la'
# alias lcsd='colorls --sort-dirs -la'
# alias lcsf='colorls --sort-files -la'

# Kubernetes
alias k='kubectl'
alias kgp='kubectl get pods'
alias kgs='kubectl get services'
alias kgn='kubectl get nodes'
alias kdp='kubectl describe pods'
alias kds='kubectl describe services'
alias kdn='kubectl describe nodes'

export EDITOR='vim'
export LANG=en_US.UTF-8
export ARCHFLAGS="-arch x86_64"

# load git auto completion if it exists
if [ -f /opt/local/etc/profile.d/bash_completion.sh ]; then
  . /opt/local/etc/profile.d/bash_completion.sh
fi

# Activate direnv
eval "$(direnv hook zsh)"

# Autocompletion
autoload -U +X bashcompinit && bashcompinit
autoload -U +X compinit && compinit
autoload -U +X promptinit && promptinit

# Rust/Cargo
source "$HOME/.cargo/env"

eval "$(starship init zsh)"

# Created by `pipx` on 2024-06-13 19:54:50
export PATH="$PATH:/Users/brybiggs/.local/bin"
