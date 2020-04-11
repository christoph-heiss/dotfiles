#!/usr/bin/env bash

set -e
set -u

YAY_OPTIONS="--sudoloop --noconfirm --nodiffmenu --noeditmenu --noupgrademenu"
ARCH_PACKAGES_GENERIC=arch-packages-generic.txt
ARCH_GNOME_PACKAGES=arch-gnome-packages.txt
ARCH_GNOME_PACKAGES_UNWANTED=arch-gnome-packages-unwanted.txt
ARCH_FLATPAK_PACKAGES=arch-flatpak-packages.txt

[ -z ${WITH_GUI+x} ] && WITH_GUI=n || true


# Enable pacman colors
sudo sed -i 's/^#Color$/Color/' /etc/pacman.conf

# Instruct makepkg to use (1.5 * count) cores while compiling
sudo sed -i "s/#MAKEFLAGS=\"-j2\"/MAKEFLAGS=\"-j$((`nproc` * 3 / 2))\"/g" /etc/makepkg.conf

# Install yay
if ! hash yay 2> /dev/null; then
    yay_tmpdir=$(mktemp -d)
    pushd $yay_tmpdir
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    popd
fi

# Update packages
yay -Syu $YAY_OPTIONS

# Install all wanted packages
yay -S $YAY_OPTIONS --needed - < $ARCH_PACKAGES_GENERIC

if [[ $WITH_GUI == y ]]; then
    yay -S $YAY_OPTIONS --needed - < $ARCH_GNOME_PACKAGES

    for p in $(cat $ARCH_GNOME_PACKAGES_UNWANTED); do
        yay -Q $p >/dev/null 2>&1 && yay -Rncs $p || true
    done

    flatpak install --user --assumeyes --noninteractive $(cat $ARCH_FLATPAK_PACKAGES)
fi

# Clean up package cache
yay -Scc --noconfirm

./common.sh
cp -av files/.zsh_platform_linux $HOME/.zsh_platform

