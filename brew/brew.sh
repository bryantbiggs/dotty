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
brew bundle --file="./brew/Brewfile"

# =====================================================
# Install App Store apps
mas signin --dialog bryantbiggs@gmail.com
mas install 1091189122  # Bear
mas install 411246225   # Caffeine
mas install 504544917   # Clear
mas install 441258766   # Magnet
mas install 512617038   # Snappy
mas install 1176895641  # Spark
mas upgrade             # Update apps

# =====================================================
# Update, clean, check
brew update; brew upgrade; brew prune; brew cleanup; brew cask cleanup; brew doctor

echo "Homebrew complete!"
