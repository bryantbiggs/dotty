#!/bin/bash

if test ! $(which brew); then
  echo "Installing homebrew..."
  sudo -u $USER /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" \ </dev/null
fi

# =====================================================
# Ensure brew is latest
brew update; brew upgrade

# =====================================================
# Install apps listed in Brewfile
echo "Downloading and installing apps..."
brew bundle --file="./Brewfile"

# =====================================================
# Install App Store apps

# Amphetamine
mas install 937984704
# Bear
mas install 1091189122
# Magnet
mas install 441258766
# Xcode
mas install 497799835
 # Update apps
mas upgrade

# =====================================================
# Update, clean, check
brew update; brew upgrade; brew cleanup; brew doctor

echo "Homebrew complete!"
