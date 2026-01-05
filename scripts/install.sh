#!/usr/bin/env bash
set -e

# -------------------------------------------------
# CONFIG
# -------------------------------------------------
PACMAN_LIST="../pkg/pacman"
AUR_LIST="../pkg/aur"

# -------------------------------------------------
# CHECKS
# -------------------------------------------------
if ! command -v pacman >/dev/null; then
  echo "❌ This script must be run on Arch Linux"
  exit 1
fi

# -------------------------------------------------
# SYSTEM UPDATE
# -------------------------------------------------
echo "🔄 Updating system..."
sudo pacman -Syu --noconfirm

# -------------------------------------------------
# INSTALL PACMAN PACKAGES
# -------------------------------------------------
echo "📦 Installing pacman packages..."
sudo pacman -S --needed --noconfirm $(grep -vE '^\s*#|^\s*$' "$PACMAN_LIST")

# -------------------------------------------------
# INSTALL AUR PACKAGES (if any)
# -------------------------------------------------
if [[ -f "$AUR_LIST" ]]; then
  if ! command -v yay >/dev/null; then
    echo "📦 Installing yay..."
    sudo pacman -S --needed --noconfirm base-devel git
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    (cd /tmp/yay && makepkg -si --noconfirm)
  fi

  echo "📦 Installing AUR packages..."
  yay -S --needed --noconfirm $(grep -vE '^\s*#|^\s*$' "$AUR_LIST")
fi

echo "✅ Base system packages installed"
echo "➡️  Next step: run ./postinstall.sh"