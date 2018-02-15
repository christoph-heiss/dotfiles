#!/bin/bash
# Copies all dotfiles to the repo.

set -e
set -u

if [[ "$(basename `pwd`)" != "dotfiles" ]]; then
	echo "Please execute this script in the repo's folder!"
	exit 1
fi

rm -rf files/
mkdir -p files/

cp ~/.bashrc files/
cp ~/.bash_{aliases,colors,profile,utils} files/
cp ~/.gitconfig files/
cp ~/.tmux.conf files/

if [[ "`uname`" == Darwin ]]; then
	cp ~/.hammerspoon/init.lua files/
fi
