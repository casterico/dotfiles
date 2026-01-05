#!/usr/bin/env bash
set -euo pipefail

echo "==> Configuring fish shell..."

# Ensure config dir
mkdir -p "$HOME/.config/fish"

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
  gazorby/fish-abbreviation-tips \
  IlanCosman/tide@v6"

# -------------------------------------------------
# Configure Tide (only first time)
# -------------------------------------------------
if [[ ! -f "$HOME/.config/fish/tide/config.fish" ]]; then
  echo "==> Configuring tide..."
  fish -c "tide configure --auto \
    --style=Lean \
    --prompt_colors=Default \
    --show_time=No \
    --lean_prompt_height=One \
    --prompt_connection=Solid \
    --prompt_spacing=Compact \
    --icons=Many \
    --transient=No"
fi

# -------------------------------------------------
# Write base config.fish
# -------------------------------------------------
echo "==> Writing config.fish..."

cat > "$HOME/.config/fish/config.fish" <<'EOF'
# Disable greeting
set -g fish_greeting

# Editors
set -gx EDITOR micro
set -gx VISUAL micro

# Pager
set -gx PAGER less

# Aliases
alias ls='ls --color=auto'
alias ll='ls -lah'

# Abbreviations
abbr -a g git
abbr -a gs git status
abbr -a ga git add
abbr -a gl git log --oneline --graph --decorate
abbr -a gp git pull
abbr -a gc git commit
abbr -a v micro
abbr -a cl clear
abbr -a ff fastfetch
abbr -a pmi sudo pacman -S
abbr -a pmr sudo pacman -Rns
abbr -a pmu sudo pacman -Syu
abbr -a pms pacman -Ss
abbr -a pmq pacman -Qqe
abbr -a .. cd ..
abbr -a ... cd ../..
abbr -a .... cd ../../..

# FZF
set -gx FZF_DEFAULT_OPTS '--height 40% --layout=reverse --border'
EOF

echo "✅ Fish configuration complete"