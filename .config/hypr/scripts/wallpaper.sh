#!/bin/sh

WALLPAPER_PATH="$(hyprctl hyprpaper listactive | awk 'NR==1 {print $3}')"

cp "$WALLPAPER_PATH" ~/.current_wallpaper

NEW_PATH="/usr/share/backgrounds/background.png"

sudo cp "$WALLPAPER_PATH" "$NEW_PATH"
sudo chmod 644 "$NEW_PATH"
sudo chown greeter "$NEW_PATH"

echo "" >~/.config/hypr/hyprpaper.conf
echo "preload = $WALLPAPER_PATH" >>~/.config/hypr/hyprpaper.conf
echo "wallpaper = , $WALLPAPER_PATH" >>~/.config/hypr/hyprpaper.conf
