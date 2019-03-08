#!/bin/bash
# =====================================================
# NOTE - dotfiles will have to be downloaded manually first
# =====================================================
# Homebrew (applications)
bash brew/brew.sh

# =====================================================
# OSX settings
bash env/macos.sh

# =====================================================
# Git settings
ln -s $HOME/Documents/dotty/git/.git-completion.bash $HOME/.git-completion.bash
ln -s $HOME/Documents/dotty/git/.gitconfig $HOME/.gitconfig

# =====================================================
# Atom settings
# ln -s $HOME/Documents/dotty/.atom $HOME/.atom
# apm install --packages-file $HOME/.atom/packages.list

# =====================================================
# VS Code settings
bash ./code/code.sh

# =====================================================
# Python settings
pip3 install -r ./python/pip.txt

# =====================================================
# Hyper.js terminal
ln -s $HOME/Documents/dotty/shell/.hyper_plugins $HOME/.hyper_plugins
npm --prefix $HOME/.hyper_plugins install $HOME/.hyper_plugins
ln -s $HOME/Documents/dotty/shell/.hyper.js $HOME/.hyper.js

# =====================================================
# Shell settings
# Note running `sh shell/shell.sh` create a .zshrc file so run before copying over custom .zshrc
bash ./shell/shell.sh

ln -s $HOME/Documents/dotty/shell/.bash_profile $HOME/.bash_profile
ln -s $HOME/Documents/dotty/shell/.bashrc $HOME/.bashrc
rm $HOME/.zshrc
ln -s $HOME/Documents/dotty/shell/.zshrc $HOME/.zshrc

# =====================================================
# Wakatime api key
ln -s ~/OneDrive/.wakatime.cfg ~/.wakatime.cfg

# =====================================================
# All set, source it!
source ~/.bash_profile
