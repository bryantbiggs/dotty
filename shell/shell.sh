#!/bin/bash

# Setup Iterm2
./iterm2/iterm2.sh

# Colorls
sudo gem install colorls
mkdir -p $HOME/.config/Colorls

# Silence last login
touch $HOME/.hushlogin
