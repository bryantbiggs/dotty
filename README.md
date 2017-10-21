# dotfiles

My MacBook config and dotfiles

--------------------------------------------------------------------------------

![](./img/gibbonswhaatbig.jpg)

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
