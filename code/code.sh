#!/bin/bash

# Symlink settings from dotty repo
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    rm -rf /var/home/bryantbiggs/.config/Code/User
    ln -s $HOME/Documents/dotty/code/User /var/home/bryantbiggs/.config/Code/User
else
    rm -rf $HOME/Library/Application\ Support/Code/User
    ln -s $HOME/Documents/dotty/code/User $HOME/Library/Application\ Support/Code/User
fi

# Install extensions
# To generate => for EXT in $(code --list-extensions); do echo "code --install-extension $EXT"; done;

code --install-extension ahmadawais.shades-of-purple
code --install-extension bungcip.better-toml
code --install-extension christian-kohler.npm-intellisense
code --install-extension clarkyu.vscode-sql-beautify
code --install-extension GitHub.copilot
code --install-extension Gruntfuggly.todo-tree
code --install-extension hashicorp.hcl
code --install-extension hashicorp.terraform
code --install-extension ms-azuretools.vscode-docker
code --install-extension ms-kubernetes-tools.vscode-kubernetes-tools
code --install-extension ms-python.python
code --install-extension ms-python.vscode-pylance
code --install-extension PKief.material-icon-theme
code --install-extension redhat.vscode-yaml
code --install-extension rust-lang.rust-analyzer
code --install-extension serayuzgur.crates
code --install-extension solomonsscott.furnace
code --install-extension streetsidesoftware.code-spell-checker
code --install-extension svelte.svelte-vscode
code --install-extension TabNine.tabnine-vscode
code --install-extension usernamehw.errorlens
code --install-extension WakaTime.vscode-wakatime
code --install-extension wix.vscode-import-cost
