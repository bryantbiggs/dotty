# =====================================================
# ----- ZSH

# The following lines were added by compinstall
zstyle :compinstall filename '/Users/${USER}/.zshrc'

# ? (can't remember)
autoload -Uz compinit
compinit

# Pure prompt
autoload -U promptinit; promptinit
prompt pure

# Zsh-completions
fpath=(/usr/local/share/zsh-completions $fpath)

# Load plugins
plugins=(git)

# load git auto completion if it exists
if [ -f /opt/local/etc/profile.d/bash_completion.sh ]; then
  . /opt/local/etc/profile.d/bash_completion.sh
fi

# added by travis gem
[ -f /Users/bryant.biggs/.travis/travis.sh ] && source /Users/bryant.biggs/.travis/travis.sh
