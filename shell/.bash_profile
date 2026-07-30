# Login bash. Defers to .bashrc, which is the standard bash arrangement and the
# reason these two files no longer need to be byte-identical copies of each other.

[[ -f "${HOME}/.bashrc" ]] && . "${HOME}/.bashrc"
