# Clear path - clean slate
unset PATH

# Python 2.7 was removed
export python=python3

# List all path entries before the "standard" PATH
export PATH="$HOME/.cargo/bin"

# Brew
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  PATH="/home/linuxbrew/.linuxbrew/bin:${PATH}"
  PATH="/home/linuxbrew/.linuxbrew/sbin:${PATH}"
fi
if [[ "$OSTYPE" == "darwin"* ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  # Add the default directories
  PATH="${PATH}:/snap/bin"
fi

# Add the default directories AFTER the above (+=)
PATH="${PATH}:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

# goenv
export GOENV_ROOT="$HOME/.goenv"
export PATH="${GOENV_ROOT}/bin:${PATH}"
eval "$(goenv init -)"
export PATH="$GOROOT/bin:$PATH"
export PATH="$PATH:$GOPATH/bin"
export GOPROXY=direct

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

alias ls='ls -la --color=auto'
alias dir='dir --color=auto'

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
alias tfclean='find . | grep -E "(\.terraform|\.terraform.lock.hcl|\.tfsec|\.terraform.tfstate*)" | xargs rm -rf'
alias dsclean='find . | grep -E "(.DS_Store)" | xargs rm'
alias pyclean='find . | grep -E "(__pycache__|\.pyc|\.pyo$|\.pytest_cache)" | xargs rm -rf'
alias jsclean='find . | grep -E "(node_modules|\.serverless|package-lock.json|yarn.lock|dist)" | xargs rm -rf'
alias dclean='docker image prune -a && docker container prune'
alias runclean='dsclean; pyclean'

# HomeBrew
if [[ "$OSTYPE" == "darwin"* ]]; then
  alias brewup="brew update; brew outdated; mas upgrade; brew cleanup; brew doctor"
else
  alias brewup="brew update; brew outdated; brew cleanup; brew doctor"
fi

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

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  # Nerd font
  alias ls='ls -G'
  POWERLEVEL9K_MODE='nerdfont-complete'
  POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs newline status)
  POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()
  POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
  DISABLE_UPDATE_PROMPT=true

  # Autocompletion
  autoload -U +X bashcompinit && bashcompinit
  autoload -U +X compinit && compinit
  autoload -U +X promptinit && promptinit

  # source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
  export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="bg=#ffff00,fg=#000000"

  source  ~/Documents/powerlevel9k/powerlevel9k.zsh-theme

  export ZSH=$HOME/.oh-my-zsh
  source $HOME/.bashrc
  ZSH_DISABLE_COMPFIX=true
  source $HOME/.oh-my-zsh/oh-my-zsh.sh
  export LANG=en_US.UTF-8
fi

if [[ "$OSTYPE" == "darwin"* ]]; then
  eval "$(starship init zsh)"
fi
