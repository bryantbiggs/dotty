#!/bin/bash

# Symlink settings from dotty repo
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    rm -rf /var/home/bryantbiggs/.config/Code/User
    ln -s $HOME/Documents/dotty/code/User /var/home/bryantbiggs/.config/Code/User
else
    rm -rf $HOME/Library/Application\ Support/Code/User
    ln -s $HOME/Documents/dotty/code/User $HOME/Library/Application\ Support/Code/User
fi
