#!/bin/bash
set -e

echo "Installing dependencies"

#AMD GPU drivers
sudo pacman -S --needed lib32-mesa vulkan-radeon lib32-vulkan-radeon vulkan-icd-loader lib32-vulkan-icd-loader

# Useful applications
sudo pacman -S --needed fuzzel qutebrowser bitwarden qalculate-gtk okular btop gwenview mpv libreoffice-fresh steam

# Programming languages
sudo pacman -S --needed zed neovim tree-sitter-cli uv go zig npm bun jdk-openjdk lazydocker dbeaver docker docker-compose

# Fish shell and overall utilities
sudo pacman -S --needed cliphist zip unzip nwg-look steam fuzzel fish thunar thunar-archive-plugin thunar-media-tags-plugin thunar-volman

sudo pacman -Syu niri xwayland-satellite xdg-desktop-portal-gnome xdg-desktop-portal-gtk alacritty dms-shell-niri matugen cava qt6-multimedia-ffmpeg
systemctl --user add-wants niri.service dms

echo "Done installing dependencies"

echo "Cloning dotfiles. Change for http or your own fork."
mkdir github && cd github
git clone git@github.com:RandaeGS/dotfiles.git dotfiles

echo "Making soft links"
ln -s ~/github/dotfiles/fish ~/.config/fish
ln -s ~/github/dotfiles/niri ~/.config/niri
ln -s ~/github/dotfiles/fuzzel ~/.config/fuzzel
ln -s ~/github/dotfiles/ideavimrc ~/.ideavimrc

echo "Changing shell"
chsh -s /usr/bin/fish
