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

echo "Beginning install of sysyem packages. ZSH, hyprland, etc. \n"
yay -S --noconfirm --needed zsh zsh-autosuggestions zsh-syntax-highlighting
yay -S --noconfirm --needed neovim tmux ripgrep fd fzf bat exa tree btop jq curl wget unzip zip stow less ffmpeg
yay -S --noconfirm --needed hyprland hyprlock hyprpaper hypridle
yay -S --noconfirm --needed waybar grimblast wofi wl-clipboard ghostty starship nwg-dock-hyprland wlogout
echo "Installing and flushing fonts\n"
yay -S --noconfirm --needed ttf-font-awesome ttf-jetbrains-mono-nerd ttf-firacode-nerd ttf-hack-nerd fontconfig
fc-cache -f -v
echo "Installing networking and audio packages\n"
yay -S --noconfirm --needed networkmanager networkmanager-dmenu pavucontrol sof-firmware alsa-firmware
echo "Installing Dolphin, wallpaper engine, Firefox, Zen Browser, Steam, Spotify, Webcord/Discord\n"
yay -S --noconfirm --needed linux-wallpaperengine dolphin firefox zen-browser steam spotify webcord discord
yay -S --noconfirm --needed go nerdfetch nitch zoxide
git clone https://github.com/wfryan/plankton.git
cd ~/plankton
stow hypr waybar starship zsh wofi nvim nwg-dock-hyprland ghostty

chsh -s $(which zsh)
clear
sudo systemctl reboot
