#!/usr/bin/env bash

set -e
set -u

cd "$(dirname "${BASH_SOURCE[0]}")"

YAY_OPTIONS="--sudoloop --noconfirm --nodiffmenu --noeditmenu --noupgrademenu"
ARCH_PACKAGES_GENERIC=packages/arch/generic.txt
ARCH_GNOME_PACKAGES=packages/arch/gnome.txt
ARCH_GNOME_EXTENSIONS=packages/arch/gnome-shell-extensions.txt
ARCH_GNOME_PACKAGES_UNWANTED=packages/arch/gnome-unwanted.txt
ARCH_FLATPAK_PACKAGES=packages/arch/flatpak.txt

GNOME_SHELL_EXTS_PATH=$HOME/.local/share/gnome-shell/extensions

[ -z ${WITH_GUI+x} ] && WITH_GUI=n || true


# Enable `Color`, `CheckSpace` and `VerbosePkgLists` for pacman
sudo sed -i \
    's/^#Color$/Color/;s/^#CheckSpace/CheckSpace/;s/^#VerbosePkgLists/VerbosePkgLists/' \
    /etc/pacman.conf

# Instruct makepkg to use (1.5 * count) cores while compiling
sudo sed -i "s/#MAKEFLAGS=\"-j2\"/MAKEFLAGS=\"-j$((`nproc` * 3 / 2))\"/g" /etc/makepkg.conf

# Add nvidia modules to initramfs
sudo sed -i \
    's/^MODULES=(\(.*\))$/MODULES=(\1 nvidia nvidia_modeset nvidia_uvm nvidia_drm)/g' \
    /etc/mkinitcpio.conf

sudo cp -vp files/pacman-nvidia-initcpio.hook /etc/pacman.d/hooks/nvidia-initcpio.hook

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

    while read -r p; do
        yay -Q $p >/dev/null 2>&1 && yay -Rnc $YAY_OPTIONS $p || true
    done < $ARCH_GNOME_PACKAGES_UNWANTED

    flatpak install --user --assumeyes --noninteractive flathub $(cat $ARCH_FLATPAK_PACKAGES)

    # Install shell extensions
    mkdir -p $GNOME_SHELL_EXTS_PATH
    pushd $GNOME_SHELL_EXTS_PATH
    while read -r ext; do
        info=($ext)
        git clone "${info[0]}" "${info[1]}"
    done < $ARCH_GNOME_EXTENSIONS
    popd
fi

# Clean up package cache
yay -Scc --noconfirm

# wireshark group for capture support without sudo
# informant group for hook support without sudo
usermod --append --groups wireshark informant $(whoami)

./common.sh
cp -vp files/.zsh_platform_linux $HOME/.zsh_platform
