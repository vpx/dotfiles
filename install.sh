#!/bin/bash

# Update the system
sudo pacman -Syu --noconfirm

# Install packages
packages=(
    "alacritty"
    "bluez"
    "bluez-utils"
    "clang"
    "fastfetch"
    "firefox"
    "flameshot"
    "git"
    "gcc"
    "grim"
    "gsettings-desktop-schemas"
    "less"
    "neovim"
    "ripgrep"
    "rofi"
    "slurp"
    "tmux"
    "ttf-noto-nerd"
    "vi"
    "wl-clipboard"
    "wlr-randr"
    "xdg-desktop-portal-hyprland"
    "fish"
    "zathura"
    "zathura-pdf-mupdf"
    "texlive"
    "texlive-bin"
    "texlive-latex"
    "texlive-latexextra"
    "texlive-formatsextra"
    "unzip"
    "openssh"
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

# Remove hyprland config directory
rm -r .config/hypr/

# Temporary install stow, use it, then remove it
sudo pacman -S stow --noconfirm
stow .
sudo pacman -Rns stow --noconfirm

# Change the shell to fish
chsh -s ${which fish}

# Ask the user if they want to store git credentials
read -p "Do you want to store your Git credentials permanently? (y/n): " response
if [[ "$response" =~ ^[Yy]$ ]]; then
    git config --global credential.helper store
fi
