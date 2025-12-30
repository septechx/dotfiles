#!/bin/bash

WALLPAPER_PATH="$1"

cp "$WALLPAPER_PATH" ~/.current_wallpaper

NEW_PATH="/usr/share/backgrounds/background.png"

sudo cp "$WALLPAPER_PATH" "$NEW_PATH"
sudo chmod 644 "$NEW_PATH"
sudo chown greeter "$NEW_PATH"

echo "" >~/.config/hypr/hyprpaper.conf
{
  echo "wallpaper {"
  echo "    monitor = DP-2"
  echo "    path = $WALLPAPER_PATH"
  echo "    fit_mode = cover"
  echo "}"
} >>~/.config/hypr/hyprpaper.conf

killall hyprpaper
hyprpaper &
disown
