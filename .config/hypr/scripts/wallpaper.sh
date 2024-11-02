#! /bin/bash

WALLPAPER_PATH="$(hyprctl hyprpaper listactive | awk 'NR==1 {print $3}')"

cp WALLPAPER_PATH ~/.current_wallpaper

echo "" > ~/.config/hypr/hyprpaper.conf
echo "preload = $WALLPAPER_PATH" >> ~/.config/hypr/hyprpaper.conf
echo "wallpaper = , $WALLPAPER_PATH" >> ~/.config/hypr/hyprpaper.conf
