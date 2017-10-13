#!/bin/bash

echo "Downloading - Homebrew"
sudo -u $USER /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" \ </dev/null

echo "DONE - Homebrew!!!"

brew bundle
