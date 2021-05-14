#!/usr/bin/env bash

set -e
set -u

[[ ! -d $HOME/.config/base16-shell ]] && git clone https://github.com/chriskempson/base16-shell.git $HOME/.config/base16-shell || true
[[ ! -d $HOME/.oh-my-zsh ]] && sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

cp -vp files/.{alacritty.yml,gitconfig,tmux.conf,zshrc} $HOME/

touch $HOME/.z

ZSH_CUSTOM=$HOME/.oh-my-zsh/custom
[[ ! -d $ZSH_CUSTOM/themes/spaceship-prompt ]] && git clone https://github.com/denysdovhan/spaceship-prompt.git $ZSH_CUSTOM/themes/spaceship-prompt || true
ln -sf $ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme $ZSH_CUSTOM/themes/spaceship.zsh-theme

[[ ! -d $ZSH_CUSTOM/plugins/zsh-syntax-highlighting ]] && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting  || true
