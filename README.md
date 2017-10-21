# dotfiles
My MacBook config and dotfiles

# Atom
- Copy `.atom/` to root directory and install packages from packages.list

```bash
cp -r Documents/dotfiles/.atom .
apm install --packages-file .atom/packages.list
```

- To update list of installed packages:
```bash
cd .atom/
apm list --installed --bare > packages.list
```
