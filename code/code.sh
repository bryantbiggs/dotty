#!/bin/bash

<<<<<<< HEAD
# Symlink settings from dotty repo
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    rm -rf /var/home/bryantbiggs/.config/Code/User
    ln -s $HOME/Documents/dotty/code/User /var/home/bryantbiggs/.config/Code/User
else
    rm -rf $HOME/Library/Application\ Support/Code/User
    ln -s $HOME/Documents/dotty/code/User $HOME/Library/Application\ Support/Code/User
fi
=======
# Install extensions
# To generate => for EXT in $(code --list-extensions); do echo "code --install-extension $EXT"; done;

code --install-extension ahmadawais.shades-of-purple
code --install-extension aws-scripting-guy.cform
code --install-extension bungcip.better-toml
code --install-extension christian-kohler.npm-intellisense
code --install-extension dbaeumer.vscode-eslint
code --install-extension dsteenman.cloudformation-yaml-snippets
code --install-extension erd0s.terraform-autocomplete
code --install-extension esbenp.prettier-vscode
code --install-extension henriiik.docker-linter
code --install-extension hnw.vscode-auto-open-markdown-preview
code --install-extension HookyQR.beautify
code --install-extension kalitaalexey.vscode-rust
code --install-extension matklad.ra-lsp
code --install-extension mauve.terraform
code --install-extension ms-azuretools.vscode-docker
code --install-extension ms-kubernetes-tools.vscode-kubernetes-tools
code --install-extension ms-python.python
code --install-extension ms-vscode.Go
code --install-extension octref.vetur
code --install-extension PKief.material-icon-theme
code --install-extension redhat.vscode-yaml
code --install-extension serayuzgur.crates
code --install-extension solomonsscott.furnace
code --install-extension TabNine.tabnine-vscode
code --install-extension vadimcn.vscode-lldb
code --install-extension WakaTime.vscode-wakatime
code --install-extension wix.vscode-import-cost

rm -rf $HOME/Library/Application\ Support/Code/User
ln -s $HOME/Documents/dotty/code/User $HOME/Library/Application\ Support/Code/User
>>>>>>> c2780c407fcac88da25e869a3a670e93f419aa69
