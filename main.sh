#!/bin/bash

# Homebrew (applications)
bash brew/brew.sh

# OSX settings
bash env/macos.sh

# Git settings
rm $HOME/{.git-completion.bash,.gitconfig}
ln -s $HOME/Documents/dotty/git/.git-completion.bash $HOME/.git-completion.bash
ln -s $HOME/Documents/dotty/git/.gitconfig $HOME/.gitconfig

# Kubernetes settings
bash ./kubernetes/k8s.sh

# VS Code settings
bash ./code/code.sh

# Python settings
pip3 install -r ./python/pip.txt

# Shell settings
# Note running `sh shell/shell.sh` create a .zshrc file so run before copying over custom .zshrc
bash ./shell/shell.sh

rm $HOME/{.bash_profile,.bashrc,.zshrc}
ln -s $HOME/Documents/dotty/shell/.bash_profile $HOME/.bash_profile
ln -s $HOME/Documents/dotty/shell/.bashrc $HOME/.bashrc
ln -s $HOME/Documents/dotty/shell/.zshrc $HOME/.zshrc
mkdir -p $HOME/.config/colorls
ln -s $HOME/Documents/dotty/shell/dark_colors.yaml $HOME/.config/colorls/dark_colors.yaml

# Wakatime api key
ln -s $HOME/OneDrive/.wakatime.cfg $HOME/.wakatime.cfg

# All set, source it!
source $HOME/.bash_profile
