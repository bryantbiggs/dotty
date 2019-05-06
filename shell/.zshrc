# Misc
alias ocat'cat'
alias cat='bat'

# Network
alias ns='dig +short NS'
alias tr='sudo tcptraceroute'

# Ansible
alias ap='ansible-playbook'
alias ag='ansible-galaxy'

# Docker
alias dclean='docker rmi -f $(docker images --filter "dangling=true" -q --no-trunc)'

# Terraform
alias tf='terraform'

# Heptio Authenticator AWS (EKS)
alias hauth='heptio-authenticator-aws'

# Clean Apple's crap
alias dsclean='find . | grep -E "(.DS_Store)" | xargs rm'

# Clean up python generated files
alias pyclean='find . | grep -E "(__pycache__|\.pyc|\.pyo$|\.pytest_cache)" | xargs rm -rf'

# Autoflake the shit out of that directory
alias flakeit='autoflake -i -r --expand-star-imports --remove-all-unused-imports  --remove-unused-variables .'

# Run all clean commands
alias runclean='dsclean; pyclean'

# Brew all the things!!!
alias brewup="brew update; brew outdated; mas upgrade; brew cleanup; brew doctor"

# =====================================================
# colorls

# Enable tab completion of flags
source $(dirname $(gem which colorls))/tab_complete.sh

# Base formats
alias lc='colorls -la'
alias lcd='colorls --dirs -la'
alias lcf='colorls --files -la'
alias lcsd='colorls --sort-dirs -la'
alias lcsf='colorls --sort-files -la'

# =====================================================
# Golang

# Add bin to PATH
export GOPATH=$(go env GOPATH)
export PATH=$PATH:$GOPATH/bin

# =====================================================
# Kubernetes

alias k='kubectl'
alias kgp='kubectl get pods'
alias kgs='kubectl get services'
alias kgn='kubectl get nodes'
alias kdp='kubectl describe pods'
alias kds='kubectl describe services'
alias kdn='kubectl describe nodes'

# =====================================================
# HomeBrew
export PATH="/usr/local/sbin:$PATH"

# =====================================================

# Autocompletion 

autoload -U +X bashcompinit && bashcompinit
autoload -U +X compinit && compinit
autoload -U +X promptinit && promptinit

# Activate direnv
eval "$(direnv hook zsh)"

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/Users/${USER}/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
ZSH_THEME="powerlevel9k/powerlevel9k"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git docker)

# Antigen for zsh shell
# source /usr/local/share/antigen/antigen.zsh

source $HOME/.bashrc
ZSH_DISABLE_COMPFIX=true
source $ZSH/oh-my-zsh.sh
export LANG=en_US.UTF-8

# Nerd font
alias ls='ls -G's
POWERLEVEL9K_MODE='nerdfont-complete'
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs newline status)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
DISABLE_UPDATE_PROMPT=true

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim'
fi

# Compilation flags
export ARCHFLAGS="-arch x86_64"

