# Sourced for login shells only, after .zshenv and before .zshrc.
#
# This exists for one macOS-specific reason. macOS runs /usr/libexec/path_helper
# between .zshenv and .zprofile, and it rebuilds PATH with the system directories
# in front, demoting everything .zshenv set. Re-sourcing the PATH construction
# here restores the intended order. Rebuilding is idempotent.
#
# Linux has no path_helper, so this is a no-op there. Anything that belongs to
# every shell goes in .zshenv; anything interactive goes in .zshrc.

if [[ "$OSTYPE" == darwin* ]]; then
  source "${HOME}/Documents/dotty/shell/path.zsh"
fi
