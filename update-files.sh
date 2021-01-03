#!/usr/bin/env bash
# Copies all dotfiles to the repo.

set -eu

cd "$(dirname "${BASH_SOURCE[0]}")"

cp -av \
    ~/.alacritty.yml \
    ~/.gitconfig \
    ~/.tmux.conf \
    ~/.zshrc \
    ~/.config/htop/htoprc \
    files/

cp -av ~/.config/amp/config.yml files/amp.yml

platform=$(uname | tr '[A-Z]' '[a-z]')
cp -av ~/.zsh_platform files/.zsh_platform_$platform
