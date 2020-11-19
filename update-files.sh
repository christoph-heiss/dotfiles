#!/bin/bash
# Copies all dotfiles to the repo.

set -e
set -u

cd "$(dirname "${BASH_SOURCE[0]}")"


cp -v \
    ~/.zshrc \
    ~/.gitconfig \
    ~/.tmux.conf \
    ~/.config/nvim/init.vim \
    ~/.config/htop/htoprc \
    files/


case `uname` in
Linux )
    cp -v ~/.zsh_platform files/.zsh_platform_linux

    ;;

Darwin )
    cp -v ~/.zsh_platform files/.zsh_platform_darwin

    ;;
esac
