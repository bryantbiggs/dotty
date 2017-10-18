# Brew all the things
alias brewup="brew update; brew upgrade; brew prune; brew cleanup; brew doctor"

# Directory tree shortcut
alias vTree="tree -I \"node_modules\""

export PATH="/usr/local/bin:$PATH"


# ======================================================
# Python

# Pylint
export PATH="/Users/bryant/anaconda/bin/pylint"

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

# Activate ZSH shell
exec ZSH
