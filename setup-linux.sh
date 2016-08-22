#!/usr/bin/env bash

set -e

# install pacaur
sudo pacman -S git bash-completion
git clone --depth=1 https://github.com/rmarquis/pacaur
cd pacaur
sudo cp pacaur /usr/local/bin/
sudo cp bash.completion /usr/share/bash-completion/completions/pacaur
sudo mkdir -p /etc/xdg/pacaur
sudo cp config /etc/xdg/pacaur/
cd ..
rm -rf ./pacaur


# install pacaur requirements
sudo pacman -S expac 

pacaur --noconfirm --noedit -S \
          scrot thefuck dropbox youtube-dl markdown speedometer htop \
          nodejs npm texlive-most gimp screenfetch geary nmap avahi \
          sublime-text-dev intel-ucode cups cups-filters ghostscript \
          ttf-meslo fontconfig vlc libva-vdpau-driver spotify cmake \
          iotop perl-mime-tools perl-net-smtp-ssl perl-authen-sasl \
          qemu

pacaur -Qs hplib && pacaur -Rns hplib

# fix avahi
sudo groupadd -r -g 84 avahi
sudo useradd -r -u 84 -g avahi -d / -s /bin/false -c avahi avahi

sudo npm install -g gulp

cp -va files/. $HOME/
