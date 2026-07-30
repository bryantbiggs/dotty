# Dotty

<img src="../img/gibbonswhaatbig.jpg" style="margin: 5px 5px -10px 5px; border: 2px solid black;" />
<div style="text-align: center;">
  <em>Photo credit: Roy Lichtenstein</em>
</div>

Cross-platform dotfiles for macOS and Linux. One set of files; the differences
are branched at runtime on `$OSTYPE` rather than kept in parallel copies.

## Install

```sh
git clone git@github.com:bryantbiggs/dotty.git ~/Documents/dotty
cd ~/Documents/dotty
./install.sh --check     # report what would change, modify nothing
./install.sh             # link the dotfiles
./install.sh --with-packages   # also install brew and apt packages
```

Re-running is a no-op. Anything already in place is moved to a timestamped
directory under `~/.dotty-backup/` rather than deleted.

## Layout

| Path | What it is |
| --- | --- |
| `shell/.zshenv` | Sourced for **every** zsh. PATH and environment live here. |
| `shell/path.zsh` | PATH construction, sourced by `.zshenv` and by `.zprofile` on macOS. |
| `shell/.zprofile` | Login shells. macOS only: undoes `path_helper` reordering. |
| `shell/.zshrc` | **Interactive** zsh only: aliases, prompt, completions, hooks. |
| `shell/.bashrc`, `.bash_profile` | Minimal; zsh is the login shell on both machines. |
| `git/.gitconfig` | Git configuration. |
| `vscode/settings.json` | VS Code settings. Linked as a single file, never the whole directory. |
| `linux/Brewfile`, `linux/apt-packages.txt` | Captured package state for Linux. |
| `macos/` | macOS-specific setup and Brewfile. |

## Where things go, and why it matters

zsh reads `.zshenv` for every shell, but `.zshrc` **only for interactive ones**.
Putting PATH in `.zshrc` therefore leaves it missing from anything
non-interactive: a zsh-shebang script, `ssh host '<cmd>'`, or a tool spawning
`zsh -c`. That was the state of this repo until it was fixed, and a clean
`zsh -c` could not find `go`, `terraform`, or `rg`.

The rule: **environment in `.zshenv`, interactive-only in `.zshrc`.** `install.sh`
verifies it on every run by checking that a bare `env -i zsh -c` still resolves
the toolchain.

`.zprofile` exists for one macOS-specific reason. macOS runs `path_helper`
between `.zshenv` and `.zprofile`, rebuilding PATH with the system directories in
front. Re-sourcing `path.zsh` from `.zprofile` restores the intended order.

## Compatibility

Developed against macOS (Apple Silicon) and Ubuntu 26.04. Nothing here pins an OS
version; the platform branches key off `$OSTYPE`.
