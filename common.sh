#!/usr/bin/env bash

set -e
set -u


[[ ! -d $HOME/.vim ]] && git clone --recurse-submodules -j4 https://github.com/christoph-heiss/vimfiles.git $HOME/.vim || true
ln -sf $HOME/.vim/vimrc $HOME/.vimrc

[[ ! -d $HOME/.config/base16-shell ]] && git clone https://github.com/chriskempson/base16-shell.git $HOME/.config/base16-shell || true
[[ ! -d $HOME/.nvm ]] && curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash || true

source $HOME/.nvm/nvm.sh
nvm install node

[[ ! -d $HOME/.oh-my-zsh ]] && sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

cp -va files/.{zshrc,gitconfig,tmux.conf} $HOME/

touch $HOME/.z

ZSH_CUSTOM=$HOME/.oh-my-zsh/custom
[[ ! -d $ZSH_CUSTOM/themes/spaceship-prompt ]] && git clone https://github.com/denysdovhan/spaceship-prompt.git $ZSH_CUSTOM/themes/spaceship-prompt || true
ln -sf $ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme $ZSH_CUSTOM/themes/spaceship.zsh-theme

[[ ! -d $ZSH_CUSTOM/plugins/zsh-syntax-highlighting ]] && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting  || true


zsh_path=$(which zsh)
if ! grep $zsh_path /etc/shells; then
    echo $zsh_path | sudo tee /etc/shells
fi

if [ $SHELL != $zsh_path ]; then
    echo 'Changing shell to zsh, please confirm:'
    sudo chsh -s $zsh_path $(whoami)
fi

