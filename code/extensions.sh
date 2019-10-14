#!/bin/bash

USER_DATA_DIR=${1:-.}

# Install extensions
for EXT in ahmadawais.shades-of-purple \
            akamud.vscode-theme-onedark \
            azemoh.theme-onedark \
            batisteo.vscode-django \
            brenosolutions.sqlformatter \
            donjayamanne.jupyter \
            donjayamanne.python-extension-pack \
            dunstontc.vscode-rust-syntax \
            hnw.vscode-auto-open-markdown-preview \
            HookyQR.beautify \
            magicstack.MagicPython \
            mauve.terraform \
            mohsen1.prettify-json \
            ms-kubernetes-tools.vscode-kubernetes-tools \
            ms-python.python \
            octref.vetur \
            oderwat.indent-rainbow \
            p1c2u.docker-compose \
            PeterJausovec.vscode-docker \
            PKief.material-icon-theme \
            redhat.vscode-yaml \
            rust-lang.rust \
            seansassenrath.vscode-theme-superonedark \
            shardulm94.trailing-spaces \
            solomonsscott.furnace \
            streetsidesoftware.code-spell-checker \
            VisualStudioExptTeam.vscodeintellicode \
            WakaTime.vscode-wakatime \
            wholroyd.jinja \
            zhuangtongfa.Material-theme
do
    code --install-extension $EXT --user-data-dir=$USER_DATA_DIR
done 
