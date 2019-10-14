#!/bin/bash

# Brew path
export PATH="/usr/local/bin:$PATH"

# Brew coreutils
if [[ "$OSTYPE" == "darwin"* ]]; then
    export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
fi

# krew - k8s package manager
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# rust cargo
export PATH="$HOME/.cargo/bin:$PATH"

# Activate ZSH shell
exec zsh
