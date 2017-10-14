#!/bin/bash

echo "Downloading - Homebrew"
sudo -u $USER /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" \ </dev/null

echo "Brew install"
brew bundle

# echo "Dock - Remove all default app icons"
# defaults write com.apple.dock persistent-apps -array
#
# echo "Finder - Disable the warning when changing a file extension"
# defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
#
# echo "Remove all app icons from the dock"
# defaults write com.apple.dock persistent-apps -array

echo "Install app store apps"
mas signin --dialog bryantbiggs@gmail.com
mas install 1091189122  # Bear
mas install 411246225   # Caffeine
mas install 504544917   # Clear
mas install 921458519   # DrCleaner
mas install 441258766   # Magnet
mas install 512617038   # Snappy
mas install 1176895641  # Spark
mas upgrade


echo "Update apps"
brew update; brew upgrade; brew prune; brew cleanup; brew doctor

# echo "Start docker and install codeclimate"
# brew "codeclimate/formulae/codeclimate"

source ./macos.sh
