#!/usr/bin/env bash

# install rustup
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# clone the repo
git clone https://github.com/rust-analyzer/rust-analyzer ~/rust-analyzer && cd ~/rust-analyzer

# install both the language server and VS Code extension
cargo xtask install
