#!/usr/bin/env bash

set -e

# install pacaur
sudo pacman -S git bash-completion expac cower yajl
git clone --depth=1 https://github.com/rmarquis/pacaur
sudo cp pacaur/pacaur /usr/local/bin/
sudo cp pacaur/bash.completion /usr/share/bash-completion/completions/pacaur
sudo mkdir -p /etc/xdg/pacaur
sudo cp pacaur/config /etc/xdg/pacaur/
rm -rf pacaur


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
