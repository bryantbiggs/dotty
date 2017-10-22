#!/bin/bash
# =====================================================
# NOTE - dotfiles will have to be downloaded manually first
# =====================================================
# Homebrew (applications)
sh brew/brew.sh

# =====================================================
# OSX settings
sh env/macos.sh

# =====================================================
# Git settings
cp ./git/.git-completion.bash ~
cp ./git/.gitconfig ~

# =====================================================
# Atom settings
cp -r ./.atom ~  && apm install --packages-file ~/.atom/packages.list

# =====================================================
# VS Code settings
cp -r ./code/User ~/Library/Application\ Support/Code/
sh ./code/code.sh

# =====================================================
# Python settings
# cp -r ./python/.jupyter ~
sudo pip3 install -r ./python/pip.txt

# =====================================================
# Hyper.js terminal
cp -r ./shell/.hyper_plugins ~ && npm --prefix ~/.hyper_plugins install ~/.hyper_plugins
cp ./shell/.hyper.js ~

# =====================================================
# Shell settings
# Note running `sh shell/shell.sh` create a .zshrc file so run before copying over custom .zshrc
sh ./shell/shell.sh

cp ./shell/.bash_profile ~
cp ./shell/.bashrc ~
cp ./shell/.zshrc ~

# =====================================================
# Wakatime api key
ln -s ~/OneDrive/.wakatime.cfg ~/.wakatime.cfg

# =====================================================
# All set, source it!
source ~/.bash_profile
