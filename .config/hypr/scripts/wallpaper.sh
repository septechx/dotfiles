#!/bin/bash

WALLPAPER_PATH="$1"

cp "$WALLPAPER_PATH" ~/.current_wallpaper

NEW_PATH="/usr/share/backgrounds/background.png"

sudo cp "$WALLPAPER_PATH" "$NEW_PATH"
sudo chmod 644 "$NEW_PATH"
sudo chown greeter "$NEW_PATH"

echo "" >~/.config/hypr/hyprpaper.conf
mapfile -t monitors < <(hyprctl monitors | awk '/^Monitor / {print $2}')

[ ${#monitors[@]} -eq 0 ] && monitors=("eDP-1")

for monitor in "${monitors[@]}"; do
  {
    echo "wallpaper {"
    echo "    monitor = $monitor"
    echo "    path = $WALLPAPER_PATH"
    echo "    fit_mode = cover"
    echo "}"
  } >>~/.config/hypr/hyprpaper.conf
done

killall hyprpaper 2>/dev/null
hyprpaper &
disown
