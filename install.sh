#!/bin/bash
set -euo pipefail

if ! command -v chezmoi &>/dev/null; then
  echo "Installing chezmoi..."
  brew install chezmoi
fi

chezmoi init --source "$(cd "$(dirname "$0")" && pwd)" --apply
