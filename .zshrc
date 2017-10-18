# Clean up python files
alias pyclean='find . | grep -E "(__pycache__|\.pyc|\.pyo$)" | xargs rm -rf'

# PostgreSQL DB
PATH="/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH"

# The following lines were added by compinstall
zstyle :compinstall filename '/Users/bryant/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
# End of lines configured by zsh-newuser-install

# =====================================================
# Oh-My-Zsh

# Path to your oh-my-zsh installation.
# export ZSH=/Users/bryant/.oh-my-zsh

# Set name of the theme to load.
ZSH_THEME="robbyrussell"

autoload -U promptinit; promptinit
prompt pure

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
plugins=(git)

# Language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nano'
else
  export EDITOR='nano'
fi

# load git auto completion if it exists
if [ -f /opt/local/etc/profile.d/bash_completion.sh ]; then
  . /opt/local/etc/profile.d/bash_completion.sh
fi

# Compilation flags
export ARCHFLAGS="-arch x86_64"
# =====================================================

# Directory tree shortcut
alias vTree="tree -I \"node_modules\""

export PATH="/usr/local/bin:$PATH"


# ======================================================
# Python

# Use Anacondas Python
export PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:/Users/bryant/anaconda/bin:/usr/local/git/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
# ======================================================


# =====================================================
# Golang
export GOPATH=$HOME/go_workspace
export GOROOT=/usr/local/opt/go/libexec
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin
# =====================================================


# =====================================================
# Exercism http://exercism.io
if [ -f ~/.config/exercism/exercism_completion.zsh ]; then
  . ~/.config/exercism/exercism_completion.zsh
fi
# =====================================================


# =====================================================
# NPM Global packages
export PATH="$HOME/.npm-packages/bin:$PATH"
# =====================================================
