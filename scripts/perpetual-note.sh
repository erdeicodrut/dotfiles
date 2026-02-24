#!/bin/bash

NOTE_FILE="$HOME/notes/perpetual.md"
TODAY=$(date "+## %Y-%m-%d")

# Create file if it doesn't exist
touch "$NOTE_FILE"

# Check if today's date is already at the top
if ! head -n 1 "$NOTE_FILE" | grep -q "^$TODAY$"; then
    # Prepend today's date with 2 newlines
    printf '%s\n\n\n%s' "$TODAY" "$(cat "$NOTE_FILE")" > "$NOTE_FILE"
fi

# Open in neovim with LSP diagnostics disabled
nvim -c "lua vim.diagnostic.disable()" "$NOTE_FILE"
