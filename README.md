# Dotty

My MacBook config and dotfiles

--------------------------------------------------------------------------------

<img src="./img/gibbonswhaatbig.jpg" style="margin: 5px 5px -10px 5px; border: 2px solid black;" /><div style="text-align: center;"><em>Photo credit: Roy Lichtenstein</em></div>

--------------------------------------------------------------------------------

## Atom

- Copy `.atom/` to root directory and install packages from packages.list:

```bash
$ cp -r Documents/dotfiles/.atom .
$ apm install --packages-file .atom/packages.list
```

- To update list of installed packages:

```bash
$ cd .atom/
$ apm list --installed --bare > packages.list
```

--------------------------------------------------------------------------------

## Hyper.js

- Copy `.hyper_plugins/` to root directory and npm install:

```bash
$ cp -r Documents/dotfiles/.hyper_plugins .
$ cd .hyper_plugins/
$ npm install
```

--------------------------------------------------------------------------------

## VSCode

- Copy contents of `.code` to `Library/Application Support/Code/User`:
