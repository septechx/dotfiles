#!/bin/bash

PROFILE=$("$HOME/.config/hypr/scripts/host-profile.sh")

case "$PROFILE" in
laptop)
    CONFIG="config-laptop.jsonc"
    ;;
*)
    CONFIG="config-desktop.jsonc"
    ;;
esac

killall waybar 2>/dev/null

exec waybar -c "$HOME/.config/waybar/$CONFIG" -s "$HOME/.config/waybar/style.css"
