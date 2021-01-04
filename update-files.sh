#!/usr/bin/env bash
# Copies all dotfiles to the repo.

set -eu

cd "$(dirname "${BASH_SOURCE[0]}")"

cp -av \
    $HOME/.alacritty.yml \
    $HOME/.gitconfig \
    $HOME/.tmux.conf \
    $HOME/.zshrc \
    $HOME/.config/htop/htoprc \
    files/

cp -av $HOME/.config/amp/config.yml files/amp.yml

platform=$(uname | tr '[A-Z]' '[a-z]')
cp -av $HOME/.zsh_platform files/.zsh_platform_$platform
