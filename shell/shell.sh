#!/bin/bash

# Note - will create a .zshrc file so run before copying over custom .zshrc (below)
echo "Installing oh-my-zsh.."
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

if [[ "$OSTYPE" == "darwin"* ]]; then
  # Setup Iterm2
  ./iterm2/iterm2.sh
fi

# Colorls
sudo gem install colorls
mkdir -p $HOME/.config/Colorls

# Silence last login
touch $HOME/.hushlogin

# Theme
git clone git@github.com:bhilburn/powerlevel9k.git $HOME/Documents/powerlevel9k

# https://github.com/bhilburn/powerlevel9k/wiki/Install-Instructions
git clone https://github.com/bhilburn/powerlevel9k.git $HOME/.oh-my-zsh/custom/themes/powerlevel9k

# https://github.com/ryanoasis/nerd-fonts
NERD_FONT_DIR=$HOME/Documents/nerd-fonts
git clone git@github.com:ryanoasis/nerd-fonts.git $NERD_FONT_DIR

cd $NERD_FONT_DIR && ./install.sh Hack