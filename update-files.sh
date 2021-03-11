#!/usr/bin/env bash
# Copies all dotfiles to the repo.

set -eu

cd "$(dirname "${BASH_SOURCE[0]}")"

platform=$(uname | tr '[A-Z]' '[a-z]')

cp -av \
    $HOME/.alacritty.yml \
    $HOME/.gitconfig \
    $HOME/.tmux.conf \
    $HOME/.zshrc \
    files/

if [[ $platform == darwin ]]; then
    cp -av $HOME/Library/Application\ Support/amp/config.yml files/amp.yml
else
    cp -av $HOME/.config/amp/config.yml files/amp.yml
fi

cp -av $HOME/.zsh_platform files/.zsh_platform_$platform
