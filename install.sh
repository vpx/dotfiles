#!/bin/bash

# Update the system
sudo pacman -Syu --noconfirm

# Install packages
packages=(
    "firefox"
    "neovim"
    "vi"
    "git"
    "less"
    "clang"
    "gcc"
    "flameshot"
    "rofi"
    "alacritty"
    "tmux"
    "gsettings-desktop-schemas"
    "bluez"
    "bluez-utils"
    "wl-clipboard"
    "grim"
    "slurp"
    "xdg-desktop-portal-hyprland"
    "fastfetch"
    "wlr-randr"
)

sudo pacman -S --noconfirm "${packages[@]}"

# Install yay if not already installed
if ! command -v yay &> /dev/null; then
    sudo pacman -S --noconfirm --needed git base-devel
    git clone https://aur.archlinux.org/yay.git
    cd yay || exit
    makepkg -si --noconfirm
    cd .. && rm -rf yay
fi

# Temporary install stow, use it, then remove it
sudo pacman -S stow --noconfirm
stow .
sudo pacman -Rns stow --noconfirm

# Ask the user if they want to store git credentials
read -p "Do you want to store your Git credentials permanently? (y/n): " response
if [[ "$response" =~ ^[Yy]$ ]]; then
    git config --global credential.helper store
fi
