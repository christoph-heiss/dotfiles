#!/usr/bin/env bash

set -e
set -u

# update pip
pip3 install --upgrade setuptools

[[ ! -d $HOME/.config/base16-shell ]] && git clone https://github.com/chriskempson/base16-shell.git $HOME/.config/base16-shell || true
[[ ! -d $HOME/.nvm ]] && curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash || true

source $HOME/.nvm/nvm.sh
nvm install node

[[ ! -d $HOME/.oh-my-zsh ]] && sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

cp -vp files/.{alacritty.yml,gitconfig,tmux.conf,zshrc} $HOME/

mkdir -p $HOME/.config/amp
cp -vp files/amp.yml $HOME/.config/amp/config.yml

mkdir -p $HOME/.config/htop
cp -vp files/htoprc $HOME/.config/htop/

touch $HOME/.z

ZSH_CUSTOM=$HOME/.oh-my-zsh/custom
[[ ! -d $ZSH_CUSTOM/themes/spaceship-prompt ]] && git clone https://github.com/denysdovhan/spaceship-prompt.git $ZSH_CUSTOM/themes/spaceship-prompt || true
ln -sf $ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme $ZSH_CUSTOM/themes/spaceship.zsh-theme

[[ ! -d $ZSH_CUSTOM/plugins/zsh-syntax-highlighting ]] && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting  || true
