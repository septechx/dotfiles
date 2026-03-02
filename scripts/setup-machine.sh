#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$(dirname "$SCRIPT_DIR")"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

detect_machine() {
    local hostname
    hostname=$(hostname)

    case "$hostname" in
    arch)
        echo "desktop"
        ;;
    nixos)
        echo "laptop"
        ;;
    *)
        echo "unknown"
        ;;
    esac
}

setup_desktop() {
    info "Setting up Arch Desktop configuration..."

    # Verify we're on Arch
    if [[ "$(detect_machine)" != "desktop" ]]; then
        warn "Hostname is not 'arch'. Make sure you're on the desktop machine."
        read -p "Continue anyway? (y/N) " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            exit 1
        fi
    fi

    cd "$DOTFILES_DIR"
    info "Stowing dotfiles..."
    stow . --adopt

    info "Setting up host-specific Hyprland configs..."
    "$HOME/.config/hypr/scripts/setup-host.sh"

    success "Desktop setup complete!"
    info "Run 'hyprctl reload' to apply changes, or restart Hyprland."
}

setup_laptop() {
    info "Setting up NixOS Laptop configuration..."

    if [[ "$(detect_machine)" != "laptop" ]]; then
        warn "Hostname is not 'nixos'. Make sure you're on the laptop machine."
        read -p "Continue anyway? (y/N) " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            exit 1
        fi
    fi

    cd "$DOTFILES_DIR"
    info "Stowing dotfiles..."
    stow . --adopt

    info "Setting up host-specific Hyprland configs..."
    "$HOME/.config/hypr/scripts/setup-host.sh"

    success "Laptop setup complete!"
    info "Log out and log back in to start Hyprland."
}

show_help() {
    cat <<EOF
Dotfiles Setup Script

Usage: $0 [COMMAND]

Commands:
    desktop     Setup Arch Desktop configuration
    laptop      Setup NixOS Laptop configuration
    auto        Auto-detect machine type and setup accordingly
    help        Show this help message

Examples:
    $0 desktop      # Setup desktop explicitly
    $0 laptop       # Setup laptop explicitly
    $0 auto         # Auto-detect and setup
    $0              # Same as 'auto'

EOF
}

main() {
    local command="${1:-auto}"

    case "$command" in
    desktop)
        setup_desktop
        ;;
    laptop)
        setup_laptop
        ;;
    auto)
        machine=$(detect_machine)
        if [ "$machine" == "desktop" ]; then
            setup_desktop
        elif [ "$machine" == "laptop" ]; then
            setup_laptop
        else
            error "Could not detect machine type (hostname: $(hostname))"
            error "Please specify explicitly: $0 [desktop|laptop]"
            exit 1
        fi
        ;;
    help | --help | -h)
        show_help
        ;;
    *)
        error "Unknown command: $command"
        show_help
        exit 1
        ;;
    esac
}

main "$@"
