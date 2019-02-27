#!/bin/bash

# Iterm theme
git clone git@github.com:bhilburn/powerlevel9k.git $HOME/Documents/powerlevel9k

# https://github.com/bhilburn/powerlevel9k/wiki/Install-Instructions
git clone https://github.com/bhilburn/powerlevel9k.git $HOME/.oh-my-zsh/custom/themes/powerlevel9k

# https://github.com/ryanoasis/nerd-fonts
NERD_FONT_DIR=$HOME/Documents/nerd-fonts
git clone git@github.com:ryanoasis/nerd-fonts.git $NERD_FONT_DIR

cd $NERD_FONT_DIR && ./install.sh Hack

# http://stratus3d.com/blog/2015/02/28/sync-iterm2-profile-with-dotfiles-repository/
# Specify the preferences directory
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "$HOME/Documents/dotty/shell/iterm2"
# Tell iTerm2 to use the custom preferences in the directory
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true