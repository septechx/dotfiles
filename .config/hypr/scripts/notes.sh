#!/bin/zsh

source ~/.zshrc

if [ -z "$NOTES_DIR" ]; then
  echo "ERROR: NOTES_DIR is not set."
  exit 1
fi

NOTES_SUBDIR="Quick Notes"
NOTES_PATH="$NOTES_DIR/$NOTES_SUBDIR"
mkdir -p "$NOTES_PATH"

tmp=$(mktemp)
kitty --class FloatInput nvim "$tmp"

input=$(<"$tmp")
rm "$tmp"

title="${input%%$'\n'*}"
body="${input#*$'\n'}"

if [ -z "$title" ]; then
  echo "No title provided, aborting."
  exit 1
fi

safe_title=$(echo "$title" | tr ' ' '_' | tr -cd '[:alnum:]_-')
[ -z "$safe_title" ] && safe_title="Untitled_$(date +%s)"

echo "$body" >"$NOTES_PATH/$safe_title.md"
echo "Note saved as '$safe_title' in $NOTES_PATH"
