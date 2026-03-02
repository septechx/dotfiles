#!/bin/bash

HOSTNAME=$(hostname)

case "$HOSTNAME" in
arch)
    CONFIG="config-desktop.jsonc"
    ;;
nixos)
    CONFIG="config-laptop.jsonc"
    ;;
*)
    # Default to desktop config for unknown hosts
    echo "Unknown hostname: $HOSTNAME, using desktop config"
    CONFIG="config-desktop.jsonc"
    ;;
esac

killall waybar 2>/dev/null

exec waybar -c "$HOME/.config/waybar/$CONFIG" -s "$HOME/.config/waybar/style.css"
