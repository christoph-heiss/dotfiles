#!/usr/bin/env bash

set -e

# install pacaur
sudo pacman -Syu --noconfirm
sudo pacman --noconfirm -S expac yajl
git clone --depth=1 https://github.com/rmarquis/pacaur
sudo cp pacaur/pacaur /usr/local/bin/
sudo cp pacaur/bash.completion /usr/share/bash-completion/completions/pacaur
sudo mkdir -p /etc/xdg/pacaur
sudo cp pacaur/config /etc/xdg/pacaur/
rm -rf pacaur


# Add sig for cower
gpg --recv-keys --keyserver hkp://pgp.mit.edu 1EB2638FF56C0C53

pacaur -Syu --aur --noconfirm
pacaur --noconfirm --noedit -S \
          scrot thefuck dropbox youtube-dl markdown speedometer htop \
          nodejs yarn texlive-most gimp screenfetch geary nmap avahi \
          sublime-text-dev intel-ucode cups cups-filters ghostscript \
          ttf-meslo fontconfig vlc libva-vdpau-driver spotify cmake \
          iotop perl-mime-tools perl-net-smtp-ssl perl-authen-sasl \
          qemu qemu-arch-extra bash-completion cower google-chrome 

pacaur -Qs hplib && pacaur -Rns hplib

cp -va files/.bash_{aliases,colors,profile,utils} files/.bashrc files/.gitconfig $HOME/
