#!/usr/bin/env bash
set -euo pipefail

echo "==> Configuring fish shell..."
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

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

# -------------------------------------------------
# Set fish as default shell
# -------------------------------------------------
if command -v fish >/dev/null 2>&1; then
    FISH_PATH="$(command -v fish)"

    if ! grep -q "$FISH_PATH" /etc/shells; then
        echo "==> Adding fish to /etc/shells (requires sudo)"
        echo "$FISH_PATH" | sudo tee -a /etc/shells >/dev/null
    fi

    if [ "$SHELL" != "$FISH_PATH" ]; then
        echo "==> Setting fish as default shell (requires password)"
        chsh -s "$FISH_PATH"
        echo "➡️  Logout or reboot required for shell change to take effect"
    else
        echo "==> Fish is already the default shell"
    fi
else
    echo "❌ Fish is not installed"
fi

echo "✅ Fish configuration complete"