#!/usr/bin/env bash

set -e


YAY_OPTIONS="--sudoloop --noconfirm --nodiffmenu --noeditmenu --noupgrademenu"
ARCH_PACKAGE_LIST_GENERIC=arch-packages-generic.txt
ARCH_PACKAGE_LIST_GUI=arch-packages-gui.txt


arch_generic_pre() {
        sudo sed -i 's/^#Color$/Color/' /etc/pacman.conf
        sudo sed -i "s/#MAKEFLAGS=\"-j2\"/MAKEFLAGS=\"-j$((`nproc` * 3 / 2))\"/g" /etc/makepkg.conf

        # install yay first
        yay_tmpdir=$(mktemp -d)
        pushd $yay_tmpdir
        git clone https://aur.archlinux.org/yay.git
        cd yay
        makepkg -si --noconfirm
        popd

        # update and install packages
        yay -Syu $YAY_OPTIONS

        yay -S $YAY_OPTIONS --needed - < $ARCH_PACKAGE_LIST_GENERIC
        [[ $WITH_GUI == y ]] && yay -S $YAY_OPTIONS --needed - < $ARCH_PACKAGE_LIST_GUI || true

        yay -Qs hplib && yay -Rns hplib || true
}


arch_generic_post() {
        # clean up package cache
        yay -Scc --noconfirm
}


generic_pre() {
        # install gulp globally
        yarn global add gulp
}


generic_post() {
        [[ ! -d $HOME/.vim ]] && git clone --recurse-submodules -j4 https://github.com/christoph-heiss/vimfiles.git $HOME/.vim || true
        [[ ! -d $HOME/.config/base16-shell ]] && git clone https://github.com/chriskempson/base16-shell.git $HOME/.config/base16-shell || true

        ln -sf $HOME/.vim/vimrc $HOME/.vimrc

        cp -va files/.bash_{aliases,colors,profile,utils} files/.{bashrc,gitconfig} $HOME/
        [[ $WITH_GUI == y ]] && cp -va files/.{tmux.conf,alacritty.yml} $HOME/ || true
}
