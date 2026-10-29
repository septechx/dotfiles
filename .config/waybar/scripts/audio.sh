#!/bin/sh

if command -v pulsemixer >/dev/null 2>&1; then
    exec kitty pulsemixer
fi

if [ -x "$HOME/.local/bin/pulsemixer" ]; then
    exec kitty "$HOME/.local/bin/pulsemixer"
fi

if command -v wiremix >/dev/null 2>&1; then
    exec kitty wiremix
fi

if command -v alsamixer >/dev/null 2>&1; then
    exec kitty alsamixer
fi

if command -v notify-send >/dev/null 2>&1; then
    notify-send -u critical "No audio mixer found" \
        "Install pulsemixer"
fi
