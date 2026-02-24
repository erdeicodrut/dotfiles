#!/usr/bin/env bash
set -euo pipefail

DOTCONFIG="$HOME/.config"

links=(
  "$HOME/.zshrc:$DOTCONFIG/zshrc"
  "$HOME/.tmux.conf:$DOTCONFIG/tmux/tmux.conf"
  "$HOME/.skhdrc:$DOTCONFIG/skhdrc"
  "$HOME/.yabairc:$DOTCONFIG/yabairc"
  "$HOME/.ideavimrc:$DOTCONFIG/ideavimrc"
)

for entry in "${links[@]}"; do
  target="${entry#*:}"
  link="${entry%%:*}"

  if [ -L "$link" ]; then
    echo "skip  $link (already a symlink)"
    continue
  fi

  if [ -e "$link" ]; then
    echo "back  $link -> ${link}.bak"
    mv "$link" "${link}.bak"
  fi

  ln -s "$target" "$link"
  echo "link  $link -> $target"
done
