#!/bin/bash

# Note - will create a .zshrc file so run before copying over custom .zshrc (below)
echo "Installing oh-my-zsh.."
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Setup Iterm2
./iterm2/iterm2.sh