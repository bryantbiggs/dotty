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

# Virtualenvwrapper
export WORKON_HOME=$HOME/Documents/venvs
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
. /usr/local/bin/virtualenvwrapper.sh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# awscli autocompletion
complete -C '/usr/local/bin/aws_completer' aws
