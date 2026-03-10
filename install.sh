#!/bin/bash
set -euo pipefail

# Install Homebrew if not present
if ! command -v brew &>/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install dependencies
for cmd in chezmoi age op; do
  command -v "$cmd" &>/dev/null || brew install "$cmd"
done

# Restore age key from 1Password
AGE_KEY_PATH="$HOME/.config/chezmoi/keys/age.key"
if [ ! -f "$AGE_KEY_PATH" ]; then
  echo "Restoring age key from 1Password..."
  eval "$(op signin --account my.1password.com)"
  mkdir -p "$(dirname "$AGE_KEY_PATH")"
  op item get "chezmoi age key" --account="my.1password.com" --fields password > "$AGE_KEY_PATH"
  chmod 600 "$AGE_KEY_PATH"
fi

# Apply
chezmoi init --source "$(cd "$(dirname "$0")" && pwd)" --apply
