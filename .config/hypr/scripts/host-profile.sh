#!/bin/bash

normalise_hostname() {
    local name="${1,,}"
    printf '%s' "${name%%.*}"
}

host=$(normalise_hostname "${HOSTNAME:-}")

case "$host" in
    arch|fedora) ;;
    *)
        host=$(normalise_hostname "$(hostname 2>/dev/null || cat /proc/sys/kernel/hostname 2>/dev/null)")
        ;;
esac

case "$host" in
    arch)
        profile="desktop"
        ;;
    fedora)
        profile="laptop"
        ;;
    *)
        profile=""

        if [ -r /etc/os-release ]; then
            os_id=$(. /etc/os-release && printf '%s' "${ID:-}")
            case "$os_id" in
                arch)
                    profile="desktop"
                    ;;
                fedora)
                    profile="laptop"
                    ;;
            esac
        fi

        if [ -z "$profile" ]; then
            if compgen -G "/sys/class/power_supply/BAT*" >/dev/null; then
                profile="laptop"
            else
                profile="desktop"
            fi
        fi
        ;;
esac

printf '%s\n' "$profile"
