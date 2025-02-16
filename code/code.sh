#!/bin/bash

# Symlink settings from dotty repo
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    rm -rf $HOME/.config/Code/User
    ln -s $HOME/Documents/dotty/code/User $HOME/.config/Code/User
else
    rm -rf $HOME/Library/Application\ Support/Code/User
    ln -s $HOME/Documents/dotty/code/User $HOME/Library/Application\ Support/Code/User
fi

# Install extensions
# To generate => for EXT in $(code --list-extensions); do echo "code --install-extension $EXT"; done;

code --install-extension 4ops.packer
code --install-extension aaron-bond.better-comments
code --install-extension ahmadawais.shades-of-purple
code --install-extension davidanson.vscode-markdownlint
code --install-extension fill-labs.dependi
code --install-extension github.copilot
code --install-extension github.copilot-chat
code --install-extension golang.go
code --install-extension hashicorp.hcl
code --install-extension hashicorp.terraform
code --install-extension pkief.material-icon-theme
code --install-extension redhat.vscode-yaml
code --install-extension rust-lang.rust-analyzer
code --install-extension streetsidesoftware.code-spell-checker
code --install-extension tamasfe.even-better-toml
code --install-extension wakatime.vscode-wakatime
code --install-extension zxh404.vscode-proto3
