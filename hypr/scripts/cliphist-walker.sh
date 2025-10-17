#!/bin/bash
TEMP_FILE=$(mktemp)
cliphist list >"$TEMP_FILE"

SELECTION=$(cut -f2- "$TEMP_FILE" | walker --dmenu --placeholder "Clipboard History" --theme dmenu_250)

if [ -n "$SELECTION" ]; then
  # Find the matching line and get its ID
  ID=$(awk -F'\t' -v sel="$SELECTION" '$2 == sel {print $1; exit}' "$TEMP_FILE")
  if [ -n "$ID" ]; then
    printf "%s\t%s" "$ID" "$SELECTION" | cliphist decode | wl-copy
    hyprctl dispatch sendshortcut "CTRL SHIFT,V,"
  fi
fi

rm "$TEMP_FILE"
