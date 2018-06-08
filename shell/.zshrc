# =====================================================

# Ansible
alias ap='ansible-playbook'
alias ag='ansible-galaxy'

# Docker
alias dclean='docker rmi -f $(docker images --filter "dangling=true" -q --no-trunc)'

# Terraform
alias tf='terraform'
# alias tf='terragrunt'

# PostgreSQL logins
alias psql_conf='atom /usr/local/etc/postgresql/pg_service.conf'

# Clean Apple's crap
alias dsclean='find . | grep -E "(.DS_Store)" | xargs rm'

# Clean up python generated files
alias pyclean='find . | grep -E "(__pycache__|\.pyc|\.pyo$|\.pytest_cache)" | xargs rm -rf'

# Autoflake the shit out of that directory
alias flakeit='autoflake -i -r --expand-star-imports --remove-all-unused-imports  --remove-unused-variables .'

# Run all clean commands
alias runclean='dsclean; pyclean'

# Brew all the things!!!
alias brewup="apm update --c false; pip-review --auto; brew update; brew upgrade; mas upgrade; brew prune; brew cleanup; brew cask cleanup; brew doctor"

# =====================================================

# Activate direnv
eval "$(direnv hook zsh)"

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/Users/${USER}/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

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

source ~/.bashrc
source $ZSH/oh-my-zsh.sh
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim'
fi

# Compilation flags
export ARCHFLAGS="-arch x86_64"

# added by travis gem
[ -f /Users/bryant.biggs/.travis/travis.sh ] && source /Users/bryant.biggs/.travis/travis.sh
export PATH="/usr/local/opt/freetds@0.91/bin:$PATH"

# NVM
export NVM_DIR="$HOME/.nvm"
. "/usr/local/opt/nvm/nvm.sh"

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /Users/B2/.nvm/versions/node/v6.11.5/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh ]] && . /Users/B2/.nvm/versions/node/v6.11.5/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /Users/B2/.nvm/versions/node/v6.11.5/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh ]] && . /Users/B2/.nvm/versions/node/v6.11.5/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh
