#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "==> Applying Qt theming (qt6ct/qt5ct + kvantum)..."

# Ensure dirs
mkdir -p "$HOME/.config/qt6ct"
mkdir -p "$HOME/.config/qt5ct"
mkdir -p "$HOME/.config/Kvantum"

# Copy qt6ct/qt5ct configs
if [ -f "$REPO_ROOT/config/theming/qt6ct.conf" ]; then
  cp -f "$REPO_ROOT/config/theming/qt6ct.conf" "$HOME/.config/qt6ct/qt6ct.conf"
  echo "  - qt6ct.conf copied"
fi

if [ -f "$REPO_ROOT/config/theming/qt5ct.conf" ]; then
  cp -f "$REPO_ROOT/config/theming/qt5ct.conf" "$HOME/.config/qt5ct/qt5ct.conf"
  echo "  - qt5ct.conf copied"
fi

# Copy Kvantum config + themes (if present)
if [ -f "$REPO_ROOT/config/theming/kvantum/kvantum.kvconfig" ]; then
  cp -f "$REPO_ROOT/config/theming/kvantum/kvantum.kvconfig" "$HOME/.config/Kvantum/kvantum.kvconfig"
  echo "  - kvantum.kvconfig copied"
  # Copy themes folders inside Kvantum
  cp -r "$REPO_ROOT/config/theming/kvantum/catppuccin-mocha-blue/"* "$HOME/.config/Kvantum/catppuccin-mocha-blue"
  echo "  - Kvantum themes synced"
fi

echo "✅ Qt theming applied"
echo "➡️  Close and reopen Qt apps to apply changes"
