# Interactive bash. zsh is the login shell on both machines, so this exists only
# so that an occasional "bash" session is not missing the toolchains.
#
# The previous contents were installer residue: rustup and uv append their PATH
# shims to every shell file they find, and a broot line pointed at a hardcoded
# /Users/bryantbiggs path for a tool that is not installed.

[[ -f "${HOME}/.cargo/env" ]] && . "${HOME}/.cargo/env"
[[ -f "${HOME}/.local/bin/env" ]] && . "${HOME}/.local/bin/env"
