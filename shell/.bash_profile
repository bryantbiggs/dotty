#!/bin/bash

# =====================================================
# ----- Homebrew

# Brew path
export PATH="/usr/local/bin:$PATH"

# Brew coreutils
export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"

# =====================================================
# ----- Golang

# export GOPATH=$HOME/go_workspace
# export GOROOT=/usr/local/opt/go/libexec
# export PATH=$PATH:$GOPATH/bin
# export PATH=$PATH:$GOROOT/bin

# =====================================================
# ----- NPM Global packages

# export PATH="$HOME/.npm-packages/bin:$PATH"

# Activate ZSH shell
exec zsh
