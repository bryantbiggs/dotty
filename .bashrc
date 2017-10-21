
# =====================================================
# ----- ZSH

# The following lines were added by compinstall
zstyle :compinstall filename '/Users/${USER}/.zshrc'

autoload -Uz compinit
compinit

# Not sure(?)
autoload -U promptinit; promptinit
prompt pure

# Zsh-completions
fpath=(/usr/local/share/zsh-completions $fpath)

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
plugins=(git)

# load git auto completion if it exists
if [ -f /opt/local/etc/profile.d/bash_completion.sh ]; then
  . /opt/local/etc/profile.d/bash_completion.sh
fi

# =====================================================
# ----- Aliases

# Clean up python files
alias pyclean='find . | grep -E "(__pycache__|\.pyc|\.pyo$)" | xargs rm -rf'

# Brew all the things
alias brewup="brew update; brew upgrade; brew prune; brew cleanup; brew doctor"

# ======================================================
# ----- Python


# =====================================================
# ----- Golang

# export GOPATH=$HOME/go_workspace
# export GOROOT=/usr/local/opt/go/libexec
# export PATH=$PATH:$GOPATH/bin
# export PATH=$PATH:$GOROOT/bin

# =====================================================
# ----- NPM Global packages

# export PATH="$HOME/.npm-packages/bin:$PATH"
