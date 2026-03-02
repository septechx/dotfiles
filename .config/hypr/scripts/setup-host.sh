#!/bin/bash

CONF_DIR="$HOME/.config/hypr/conf.d"
HOSTNAME=$(hostname)

echo "Setting up Hyprland configs for hostname: $HOSTNAME"

rm -f "$CONF_DIR/monitors.conf"
rm -f "$CONF_DIR/input.conf"

case "$HOSTNAME" in
arch)
    ln -sf "$CONF_DIR/monitors-arch.conf" "$CONF_DIR/monitors.conf"
    ln -sf "$CONF_DIR/input-arch.conf" "$CONF_DIR/input.conf"
    echo "Linked to desktop (arch) configs"
    ;;
nixos)
    ln -sf "$CONF_DIR/monitors-nixos.conf" "$CONF_DIR/monitors.conf"
    ln -sf "$CONF_DIR/input-nixos.conf" "$CONF_DIR/input.conf"
    echo "Linked to laptop (nixos) configs"
    ;;
*)
    # Default to desktop config
    echo "Unknown hostname '$HOSTNAME', defaulting to desktop configs"
    ln -sf "$CONF_DIR/monitors-arch.conf" "$CONF_DIR/monitors.conf"
    ln -sf "$CONF_DIR/input-arch.conf" "$CONF_DIR/input.conf"
    ;;
esac

echo "Done. Run 'hyprctl reload' to apply changes."
