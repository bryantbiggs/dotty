#!/usr/bin/env bash

export PATH="/usr/local/bin:$PATH"

if [[ "$OSTYPE" == "darwin"* ]]; then
    # Brew coreutils
    export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
    export PATH="/usr/local/sbin:$PATH"
fi

# =====================================================
# ----- ZSH

# The following lines were added by compinstall
zstyle :compinstall filename '/Users/${USER}/.zshrc'

# Zsh-completions
fpath=(/usr/local/share/zsh-completions $fpath)

# load git auto completion if it exists
if [ -f /opt/local/etc/profile.d/bash_completion.sh ]; then
  . /opt/local/etc/profile.d/bash_completion.sh
fi

# Pyenv
export PATH="/home/bryantbiggs/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# Virtualenvwrapper
export WORKON_HOME=$HOME/Documents/venvs
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
# source /usr/local/bin/virtualenvwrapper.sh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# awscli autocompletion
complete -C '/usr/local/bin/aws_completer' aws

# krew - k8s package manager
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# rust cargo
export PATH="$HOME/.cargo/bin:$PATH"
