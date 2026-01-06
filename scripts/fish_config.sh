#!/usr/bin/env bash
set -euo pipefail

echo "==> Configuring fish shell..."

# Ensure config dir
mkdir -p "$HOME/.config/fish"
mkdir -p "$HOME/.config"

# -------------------------------------------------
# Install fisher
# -------------------------------------------------
if ! fish -c "type -q fisher"; then
  echo "==> Installing fisher..."
  fish -c "curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher"
fi

# -------------------------------------------------
# Install fish plugins
# -------------------------------------------------
echo "==> Installing fish plugins..."
fish -c "fisher install \
  jethrokuan/z \
  PatrickF1/fzf.fish \
  edc/bass \
  gazorby/fish-abbreviation-tips"

# -------------------------------------------------
# Copy configs from repo -> ~/.config
# -------------------------------------------------
echo "==> Copying config.fish..."
cp -f "$REPO_ROOT/config/fish/config.fish" "$HOME/.config/fish/config.fish"

echo "==> Copying starship.toml..."
cp -f "$REPO_ROOT/config/starship/starship.toml" "$HOME/.config/starship.toml"

echo "==> Copying kitty.conf..."
cp -f "$REPO_ROOT/config/kitty/kitty.con" "$HOME/.config/kitty/Kitty.conf"

echo "✅ Fish configuration complete"