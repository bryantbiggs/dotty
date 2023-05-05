# Clear path - clean slate
unset PATH

# Python 2.7 was removed
export python=python3

# List all path entries before the "standard" PATH
PATH="$HOME/.cargo/bin:/usr/local/opt/ruby/bin:"
PATH=$PATH:$(ruby -e 'puts Gem.bindir')

# Brew coreutils
if [[ "$OSTYPE" == "darwin"* ]]; then
  PATH="$PATH:/usr/local/opt/coreutils/libexec/gnubin"
fi

# Add the default directories AFTER the above (+=)
PATH="${PATH}:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

# Golang
export GOENV_ROOT="$HOME/.goenv"
export PATH="$GOENV_ROOT/bin:$PATH"
eval "$(goenv init -)"
export PATH="$GOROOT/bin:$PATH"
export PATH="$PATH:$GOPATH/bin"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# Clean up possible duplicates in path and export
typeset -aU path
export PATH
export MANPATH=$(manpath)

# Misc
alias ocat'cat'
alias cat='bat'

# Terraform
alias tf='terraform'
alias tfi='terraform init -upgrade'
alias tfp='terraform plan'
alias tfl='terraform state list'
alias tfo='terraform output'

export TF_PLUGIN_CACHE_DIR="$HOME/.terraform.d/plugin-cache"

# Autoflake the shit out of that directory
alias flakeit='autoflake -i -r --expand-star-imports --remove-all-unused-imports  --remove-unused-variables .'

# Clean commands
alias tfclean='find . | grep -E "(\.terraform|\.terraform.lock.hcl|\.tfsec|\.terraform.tfstate*)" | xargs rm -rf'
alias dsclean='find . | grep -E "(.DS_Store)" | xargs rm'
alias pyclean='find . | grep -E "(__pycache__|\.pyc|\.pyo$|\.pytest_cache)" | xargs rm -rf'
alias jsclean='find . | grep -E "(node_modules|\.serverless|package-lock.json|yarn.lock|dist)" | xargs rm -rf'
alias dclean='docker image prune -a && docker container prune'
alias runclean='dsclean; pyclean'

# HomeBrew
alias brewup="brew update; brew outdated; mas upgrade; brew cleanup; brew doctor"

# colorls
alias lc='colorls -la'
alias lcd='colorls --dirs -la'
alias lcf='colorls --files -la'
alias lcsd='colorls --sort-dirs -la'
alias lcsf='colorls --sort-files -la'

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

# EKS login
alias eks_login='aws eks update-kubeconfig --name $1'

# load git auto completion if it exists
if [ -f /opt/local/etc/profile.d/bash_completion.sh ]; then
  . /opt/local/etc/profile.d/bash_completion.sh
fi

# awscli autocompletion
complete -C '/usr/local/bin/aws_completer' aws

# Activate direnv
eval "$(direnv hook zsh)"

# Nerd font
# alias ls='ls -G'
# POWERLEVEL9K_MODE='nerdfont-complete'
# POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs newline status)
# POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()
# POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
# DISABLE_UPDATE_PROMPT=true

# Autocompletion
# autoload -U +X bashcompinit && bashcompinit
# autoload -U +X compinit && compinit
# autoload -U +X promptinit && promptinit

# source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
# export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="bg=#ffff00,fg=#000000"

# source  ~/Documents/powerlevel9k/powerlevel9k.zsh-theme

eval "$(starship init zsh)"

source /Users/bryantbiggs/.config/broot/launcher/bash/br
