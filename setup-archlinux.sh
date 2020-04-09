#!/usr/bin/env bash

set -e
set -u

YAY_OPTIONS="--sudoloop --noconfirm --nodiffmenu --noeditmenu --noupgrademenu"
ARCH_PACKAGE_LIST_GENERIC=arch-packages-generic.txt
ARCH_PACKAGE_LIST_GUI=arch-packages-gui.txt
ARCH_GNOME_PACKAGE_LIST_UNNEEDED=arch-gnome-packages-unneeded.txt
ARCH_SNAP_LIST=arch-snaps.txt

WITH_GUI=$(grep antergos /etc/os-release && echo y || echo n)


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
yay -S $YAY_OPTIONS --needed - < $ARCH_PACKAGE_LIST_GENERIC

if [[ $WITH_GUI == y ]]; then
    yay -S $YAY_OPTIONS --needed - < $ARCH_PACKAGE_LIST_GUI

    for p in $(cat $ARCH_GNOME_PACKAGE_LIST_UNNEEDED); do
        yay -Q $p >/dev/null 2>&1 && yay -Rncs $p || true
    done

    # Setup snapd
    sudo systemctl enable --now snapd
    systemctl enable --now snapd
    sudo snap install $(cat $ARCH_SNAP_LIST)
fi

yay -Qs hplib && yay -Rns hplib || true

# Clean up package cache
yay -Scc --noconfirm

./common.sh
cp -av files/.zsh_platform_linux $HOME/.zsh_platform

