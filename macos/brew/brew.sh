#!/bin/bash

if test ! $(which brew); then
  echo "Installing homebrew..."
  sudo -u $USER /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" \ </dev/null
fi

# =====================================================
# Ensure brew is latest
brew update; brew upgrade

# =====================================================
# Install apps listed in Brewfile
echo "Downloading and installing apps..."
brew bundle --file="${HOME}/Documents/dotty/macos/brew/Brewfile"

# =====================================================
# Update, clean, check
brew update; brew upgrade; brew cleanup; brew doctor

echo "Homebrew complete!"
