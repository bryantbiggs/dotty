#!/usr/bin/env bash

# Homebrew (applications)
bash brew/brew.sh

# OSX settings
bash env/macos.sh

# Git settings
rm ~/{.git-completion.bash,.gitconfig}
ln -s ~/Documents/dotty/git/.git-completion.bash ~/.git-completion.bash
ln -s ~/Documents/dotty/git/.gitconfig ~/.gitconfig

# VS Code settings
bash ./code/code.sh

# Python settings
pip3 install -r ./python/pip.txt

# Shell settings
# Note running `sh shell/shell.sh` create a .zshrc file so run before copying over custom .zshrc
bash ./shell/shell.sh

rm ~/{.bash_profile,.bashrc,.zshrc}
ln -s ~/Documents/dotty/shell/.bash_profile ~/.bash_profile
ln -s ~/Documents/dotty/shell/.bashrc ~/.bashrc
ln -s ~/Documents/dotty/shell/.zshrc ~/.zshrc
ln -s ~/Documents/dotty/shell/.zprofile ~/.zprofile
mkdir -p ~/.config/colorls
ln -s ~/Documents/dotty/shell/dark_colors.yaml ~/.config/colorls/dark_colors.yaml

# Wakatime api key
ln -s ~/OneDrive/.wakatime.cfg ~/.wakatime.cfg

# All set, source it!
source ~/.bash_profile
