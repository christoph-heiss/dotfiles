#!/usr/bin/env bash

set -e

# install pacaur
sudo pacman -S git bash-completion
git clone --depth=1 https://github.com/rmarquis/pacaur
cd pacaur
sudo cp pacaur /usr/local/bin/
sudo cp bash.completion /usr/share/bash-completion/completions/pacaur
sudo mkdir -p /etc/xdg/pacaur
sudo cp config /etc/xdg/pacaur/config
cd ..
rm -rf ./pacaur


# install pacaur requirements
sudo pacman -S expac 

pacaur --noconfirm --noedit -S \
          scrot thefuck dropbox youtube-dl markdown speedometer htop \
          nodejs npm texlive-most gimp bash-completion screenfetch \
          sublime-text-dev intel-ucode cups cups-filters ghostscript \
          ttf-meslo fontconfig vlc libva-vdpau-driver spotify cmake \
          iotop perl-mime-tools perl-net-smtp-ssl perl-authen-sasl \
          geary

pacaur -Qs hplib && pacaur -Rns hplib

sudo npm install -g gulp

cp -va files/. $HOME/
