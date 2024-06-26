#!/usr/bin/env bash

echo "
=================================
=         Setup Pacman          =
=================================

"

sudo rm /etc/pacman.conf
sudo cp .config/pacman.conf /etc/pacman.conf
sudo mkdir /etc/ly
sudo cp .config/ly/config.ini /etc/ly/config.ini
sudo mkdir /usr/share/wayland-sessions
# sudo cp .local/share/wayland-sessions/hyprland.desktop /usr/share/wayland-sessions
sudo cp .config/dayz.conf /etc/sysctl.d/

echo "
=================================
=       Update The System       =
=================================

"

sudo pacman -Syyu --noconfirm

echo "
=================================
=     Which Graphics Card?      =
=================================

1) Intel
2) AMD
3) Nvidia
Defaults to AMD if you choose
something else

"

read GRAPHICSCARD
case $GRAPHICSCARD in
1)
  sudo pacman -S --noconfirm xf86-video-intel mesa lib32-mesa lib32-vulkan-intel vulkan-intel;;
2)
  sudo pacman -S --noconfirm xf86-video-amdgpu mesa lib32-mesa vulkan-radeon lib32-vulkan-radeon libva-mesa-driver lib32-libva-mesa-driver mesa-vdpau lib32-mesa-vdpau;;
3)
  sudo pacman -S --noconfirm nvidia-dkms nvidia-utils;;
*)
  sudo pacman -S --noconfirm xf86-video-amdgpu mesa lib32-mesa vulkan-radeon lib32-vulkan-radeon libva-mesa-driver lib32-libva-mesa-driver mesa-vdpau lib32-mesa-vdpau;;
esac

echo "
=================================
=      Installing Packages      =
=           & Dotfiles          =
=================================

"

sudo pacman -S --noconfirm ydotool wl-clipboard hyprland xdg-desktop-portal-hyprland vivaldi socat mpv firefox kitty thunar btop vim pavucontrol starship cowsay pipewire-pulse pipewire wireplumber obs-studio qt5ct kvantum git waybar lsd cmatrix lolcat yadm polkit-gnome gimp blender steam libnotify terminus-font lm_sensors pacman-contrib grim slurp discord virt-manager v4l2loopback-dkms linux-headers v4l2loopback-utils v4l-utils unzip unrar xarchiver bash-completion qemu-full audacity mpd ario 0ad supertuxkart xonotic openra libvirt kdenlive ly hugo go
git clone https://aur.archlinux.org/nwg-look.git
cd nwg-look
makepkg -si --noconfirm
cd ..
rm -rf nwg-look
git clone https://aur.archlinux.org/swaync.git
cd swaync
makepkg -si --noconfirm
cd ..
rm -rf swaync
git clone https://aur.archlinux.org/swww.git
cd swww
makepkg -si --noconfirm
cd ..
rm -rf swww
git clone https://aur.archlinux.org/fastfetch.git
cd fastfetch
makepkg -si --noconfirm
cd ..
rm -rf fastfetch
git clone https://aur.archlinux.org/tofi.git
cd tofi
makepkg -si --noconfirm
cd ..
rm -rf tofi
cd ..
rm .bashrc
rm .bash_profile
rm .profile
yadm clone https://gitlab.com/zaney/dotfiles.git

echo "
=================================
=       Starting Services       =
=================================

"

sudo usermod -aG libvirt $USER
sudo systemctl enable libvirtd.service
sudo systemctl enable libvirtd.socket
sudo systemctl start libvirtd.service
sudo systemctl start virtlogd.service
sudo systemctl enable ly.service
sudo sh -c "echo 'FONT=ter-u28n' >> /etc/vconsole.conf"

echo "
=================================
=        You're All Set!        =
=================================

Thank you for using my script!

MAKE SURE TO EDIT Hyprland's CONFIG
FILES MONITOR SECTION

"
