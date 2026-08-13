#!/usr/bin/env bash

# Keep Rust target/ directories from growing without bound.
#
# Cargo never removes stale build artifacts. Every dependency bump, feature
# change, or branch switch writes a fresh fingerprint into target/debug/deps/
# and leaves every predecessor behind, so target/ only ever grows. On a machine
# running several repos this reaches hundreds of gigabytes.
#
# Run once per machine. The per-repo [profile.dev] settings that pair with this
# live in each repo's Cargo.toml and arrive over git.

set -euo pipefail

DOTTY_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BIN_DIR="$HOME/.local/bin"
LABEL="dev.local.cargo-sweep-gc"
PLIST="$HOME/Library/LaunchAgents/${LABEL}.plist"

# Sweep these roots. Override per machine if repos live elsewhere.
SWEEP_ROOTS="${CARGO_SWEEP_ROOTS:-$HOME/Documents}"
SWEEP_DAYS="${CARGO_SWEEP_DAYS:-15}"
SWEEP_MAXSIZE="${CARGO_SWEEP_MAXSIZE:-}"

echo "==> installing cargo-sweep"
if command -v cargo-sweep >/dev/null 2>&1; then
  echo "    already present"
else
  cargo install cargo-sweep
fi

echo "==> linking cargo-sweep-gc into $BIN_DIR"
mkdir -p "$BIN_DIR"
ln -sf "$DOTTY_DIR/cargo-sweep-gc" "$BIN_DIR/cargo-sweep-gc"

case "$(uname -s)" in
  Darwin)
    echo "==> installing launchd agent ($LABEL)"
    mkdir -p "$(dirname "$PLIST")"
    cat >"$PLIST" <<PLIST_EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>${LABEL}</string>
    <key>ProgramArguments</key>
    <array>
        <string>${BIN_DIR}/cargo-sweep-gc</string>
    </array>
    <key>EnvironmentVariables</key>
    <dict>
        <key>CARGO_SWEEP_ROOTS</key>
        <string>${SWEEP_ROOTS}</string>
        <key>CARGO_SWEEP_DAYS</key>
        <string>${SWEEP_DAYS}</string>
        <key>CARGO_SWEEP_MAXSIZE</key>
        <string>${SWEEP_MAXSIZE}</string>
    </dict>
    <key>StartInterval</key>
    <integer>21600</integer>
    <key>RunAtLoad</key>
    <false/>
    <key>LowPriorityIO</key>
    <true/>
    <key>Nice</key>
    <integer>10</integer>
    <key>StandardOutPath</key>
    <string>${HOME}/.cache/cargo-sweep-launchd.log</string>
    <key>StandardErrorPath</key>
    <string>${HOME}/.cache/cargo-sweep-launchd.log</string>
</dict>
</plist>
PLIST_EOF

    launchctl unload "$PLIST" 2>/dev/null || true
    launchctl load "$PLIST"
    echo "    loaded, runs every 6 hours"
    ;;
  Linux)
    echo "==> Linux: add a timer or cron entry for $BIN_DIR/cargo-sweep-gc"
    echo "    suggested: 0 */6 * * * $BIN_DIR/cargo-sweep-gc"
    ;;
esac

echo
echo "Done. Verify with a dry run (reports without deleting):"
echo "  CARGO_SWEEP_DRYRUN=1 $BIN_DIR/cargo-sweep-gc && tail ~/.cache/cargo-sweep.log"
echo
echo "The script refuses to run while cargo or rustc is active, so a dry run"
echo "during a build reports 'skipped: build in progress' rather than sweeping."
