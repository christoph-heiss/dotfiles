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
	thefuck speedometer htop nodejs npm nmap avahi intel-ucode \
	cmake iotop perl-mime-tools perl-net-smtp-ssl perl-authen-sasl \
	bash-completion cower

# fix avahi
sudo groupadd -r -g 84 avahi || true
sudo useradd -r -u 84 -g avahi -d / -s /bin/false -c avahi avahi || true

sudo npm install -g gulp

cp -va files/.bash_{aliases,colors,profile,utils} files/.bashrc files/.gitconfig $HOME/
