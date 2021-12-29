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
code --install-extension BazelBuild.vscode-bazel
code --install-extension bradlc.vscode-tailwindcss
code --install-extension bungcip.better-toml
code --install-extension christian-kohler.npm-intellisense
code --install-extension clarkyu.vscode-sql-beautify
code --install-extension csstools.postcss
code --install-extension dbaeumer.vscode-eslint
code --install-extension DSKWRK.vscode-generate-getter-setter
code --install-extension esbenp.prettier-vscode
code --install-extension golang.go
code --install-extension hashicorp.terraform
code --install-extension henriiik.docker-linter
code --install-extension HookyQR.beautify
code --install-extension matklad.rust-analyzer
code --install-extension ms-azuretools.vscode-docker
code --install-extension ms-kubernetes-tools.vscode-kubernetes-tools
code --install-extension ms-python.python
code --install-extension ms-python.vscode-pylance
code --install-extension ms-toolsai.jupyter
code --install-extension ms-toolsai.jupyter-keymap
code --install-extension ms-toolsai.jupyter-renderers
code --install-extension panicbit.cargo
code --install-extension PKief.material-icon-theme
code --install-extension pmneo.tsimporter
code --install-extension rbbit.typescript-hero
code --install-extension redhat.vscode-yaml
code --install-extension serayuzgur.crates
code --install-extension solomonsscott.furnace
code --install-extension streetsidesoftware.code-spell-checker
code --install-extension svelte.svelte-vscode
code --install-extension TabNine.tabnine-vscode
code --install-extension WakaTime.vscode-wakatime
code --install-extension wix.vscode-import-cost
