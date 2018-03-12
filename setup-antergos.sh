#!/usr/bin/env bash

set -e

sudo pacman -S --noconfirm pacaur

pacaur -Syu --aur --noconfirm
pacaur --noconfirm --noedit -S \
          scrot thefuck dropbox youtube-dl markdown speedometer htop \
          nodejs yarn texlive-most gimp screenfetch geary nmap avahi \
          intel-ucode cups cups-filters ghostscript ttf-meslo fontconfig \
          vlc libva-vdpau-driver spotify cmake iotop perl-mime-tools \
          perl-net-smtp-ssl perl-authen-sasl qemu qemu-arch-extra \
          bash-completion google-chrome vim tmux

pacaur -Qs hplib && pacaur -Rns hplib
pacaur -Scc

yarn global add gulp

git clone --recurse-submodules -j4 https://github.com/christoph-heiss/vimfiles.git $HOME/.vim
ln -s $HOME/.vim/vimrc $HOME/.vimrc

git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell

cp -va files/.bash_{aliases,colors,profile,utils} files/.{bashrc,gitconfig,tmux.conf} $HOME/
