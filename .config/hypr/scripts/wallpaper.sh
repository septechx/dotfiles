#!/bin/bash

WALLPAPER_PATH="$(hyprctl hyprpaper listactive | awk 'NR==1 {print $3}')"

cp "$WALLPAPER_PATH" ~/.current_wallpaper

sudo cp "$WALLPAPER_PATH" /usr/share/sddm/themes/sugar-dark/background.png
sudo chmod 644 /usr/share/sddm/themes/sugar-dark/background.png
sudo chown root:sddm /usr/share/sddm/themes/sugar-dark/background.png

echo "" > ~/.config/hypr/hyprpaper.conf
echo "preload = $WALLPAPER_PATH" >> ~/.config/hypr/hyprpaper.conf
echo "wallpaper = , $WALLPAPER_PATH" >> ~/.config/hypr/hyprpaper.conf
