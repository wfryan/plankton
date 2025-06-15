#!/bin/bash
set -e
sudo -v

while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

sudo pacman -Syu 
sudo pacman -S --noconfirm --needed git base-devel linux-headers
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm
cd ~
yay -S --noconfirm --needed zsh zsh-autosuggestions zsh-syntax-highlighting
yay -S --noconfirm --needed neovim tmux ripgrep fd fzf bat exa tree btop jq curl wget unzip zip stow less ffmpeg
yay -S --noconfirm --needed hyprland hyprlock hyprpaper
yay -S --noconfirm --needed waybar grim slurp wofi wl-clipboard ghostty starship nwg-dock-hyprland wlogout
yay -S --noconfirm --needed ttf-font-awesome ttf-jetbrains-mono-nerd ttf-firacode-nerd ttf-hack-nerd fontconfig
fc-cache -f -v
yay -S --noconfirm --needed networkmanager networkmanager-dmenu pavucontrol sof-firmware alsa-firmware
yay -S --noconfirm --needed linux-wallpaperengine dolphin firefox zen-browser-bin 
yay -S go nerdfetch nitch
cd ~/plankton
stow hypr waybar starship zsh wofi nvim nwg-dock-hyprland ghostty

chsh -s $(which zsh)
nitch
