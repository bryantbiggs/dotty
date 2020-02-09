# Clear path - clean slate
unset path

# List all path entries before the "standard" PATH
PATH="\
$HOME/.cargo/bin:\
/usr/local/opt/ruby/bin:"

PATH=$PATH:$(ruby -e 'puts Gem.bindir')
PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# Brew coreutils
if [[ "$OSTYPE" == "darwin"* ]]; then
  PATH="$PATH:/usr/local/opt/coreutils/libexec/gnubin"
fi

# Add the default directories AFTER the above (+=)
PATH+=":/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

# Run commands that modify the first entries in path
eval "$(pyenv init -)"

# Clean up possible duplicates in path and export
typeset -aU path
export PATH
export MANPATH=$(manpath)

# Misc
alias ocat'cat'
alias cat='bat'

# Ansible
alias ap='ansible-playbook'
alias ag='ansible-galaxy'

# Google cloud platform
alias g='gcloud'
alias gl='gcloud components list'
alias ga='gcloud auth login --no-launch-browser'
alias gp='gcloud projects list'
alias gsp='gcloud config set project'

# Terraform
alias tf='terraform'
alias tfi='terraform init -upgrade'
alias tfp='terraform plan'
alias tfl='terraform state list'
alias tfo='terraform output'
alias tfw='terraform workspace list'
alias tfs='terraform workspace select'

# Autoflake the shit out of that directory
alias flakeit='autoflake -i -r --expand-star-imports --remove-all-unused-imports  --remove-unused-variables .'

# Clean commands
alias tfclean='find . | grep -E "(.terraform)" | xargs rm -rf'
alias dsclean='find . | grep -E "(.DS_Store)" | xargs rm'
alias pyclean='find . | grep -E "(__pycache__|\.pyc|\.pyo$|\.pytest_cache)" | xargs rm -rf'
alias jsclean='find . | grep -E "(node_modules|\.serverless|package-lock.json|yarn.lock|dist)" | xargs rm -rf'
alias dclean='docker rmi -f $(docker images --filter "dangling=true" -q --no-trunc)'
alias runclean='dsclean; pyclean'

# HomeBrew
alias brew='env PATH=${PATH//$(pyenv root)\/shims:/} brew' # suppres config warnings
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

# The next line updates PATH for the Google Cloud SDK.
if [ -f 'google-cloud-sdk/path.zsh.inc' ]; then
  . 'google-cloud-sdk/path.zsh.inc'
fi

# The next line enables shell command completion for gcloud.
if [ -f 'google-cloud-sdk/completion.zsh.inc' ]; then
  . 'google-cloud-sdk/completion.zsh.inc'
fi

# Virtualenvwrapper
if [ -f '/usr/local/bin/virtualenvwrapper.sh' ]; then
  export WORKON_HOME=$HOME/Documents/venvs
  export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
  . /usr/local/bin/virtualenvwrapper.sh
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# awscli autocompletion
complete -C '/usr/local/bin/aws_completer' aws

# Activate direnv
eval "$(direnv hook zsh)"

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

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="bg=#ffff00,fg=#000000"

source  ~/Documents/powerlevel9k/powerlevel9k.zsh-theme