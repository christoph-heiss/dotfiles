#!/usr/bin/env bash

set -e


sudo apt-get install -y curl wget apt-transport-https dirmngr

sudo tee /etc/apt/sources.list <<EOF
deb http://deb.debian.org/debian/ stable main contrib non-free
deb http://deb.debian.org/debian/ stable-updates main contrib non-free
deb http://deb.debian.org/debian-security stable/updates main
EOF

sudo apt-get update
sudo apt-get dist-upgrade -y
sudo apt-get install -y \
        wget thefuck speedometer htop nmap avahi-daemon cmake iotop bash-completion \
        vim tmux

sudo apt-get autoremove -y
sudo apt-get autoclean


git clone --recurse-submodules -j4 https://github.com/christoph-heiss/vimfiles.git $HOME/.vim
ln -s $HOME/.vim/vimrc $HOME/.vimrc

git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell

cp -va files/.bash_{aliases,colors,profile,utils} files/.{bashrc,gitconfig,tmux.conf} $HOME/
