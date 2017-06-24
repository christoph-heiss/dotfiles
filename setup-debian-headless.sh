#!/usr/bin/env bash

set -e


sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

sudo apt-get install -y curl wget apt-transport-https dirmngr

sudo tee /etc/apt/sources.list <<EOF
deb http://deb.debian.org/debian/ stable main contrib non-free
deb http://deb.debian.org/debian/ stable-updates main contrib non-free
deb http://deb.debian.org/debian-security stable/updates main
EOF

sudo apt-get update
sudo apt-get dist-upgrade -y
sudo apt-get install -y \
        wget thefuck speedometer htop nodejs nmap avahi-daemon cmake iotop bash-completion

wget "http://ftp.debian.org/debian/pool/main/n/npm/npm_1.4.21+ds-2_all.deb"
sudo dpkg -i --force-depends npm_1.4.21+ds-2_all.deb
sudo apt-get install -f -y
rm npm_1.4.21+ds-2_all.deb

sudo apt-get autoremove -y
sudo apt-get autoclean

sudo npm install -g gulp

cp -va files/.bash_{aliases,colors,profile,utils} files/.bashrc files/.gitconfig $HOME/
