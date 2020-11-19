#
# ~/.zshrc
#

# If not running interactively, do nothing
[[ $- != *i* ]] && return

export PATH="$HOME/.yarn/bin:$HOME/.cargo/bin:$HOME/.local/bin:$PATH"
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME=spaceship
HYPHEN_INSENSITIVE=true
ENABLE_CORRECTION=true

# Display red dots whilst waiting for completion
COMPLETION_WAITING_DOTS=true

# Timestamps for history
HIST_STAMPS=yyyy-mm-dd

plugins=(
    cargo
    colored-man-pages
    docker
    docker-compose
    git
    git-extras
    sudo
    z

    # must be last
    zsh-syntax-highlighting
)

if [ "$(uname)" = "Darwin" ]; then
    plugins=(osx "${plugins[@]}")
fi

source $ZSH/oh-my-zsh.sh

# Show low battery warning < 20% left
SPACESHIP_BATTERY_THRESHOLD=20

# Show execution time of last command if > 10 sec
SPACESHIP_EXEC_TIME_ELAPSED=10

SPACESHIP_EXIT_CODE_SYMBOL="✘ "
SPACESHIP_EXIT_CODE_SHOW=true
SPACESHIP_CHAR_SUFFIX=" "
SPACESHIP_TIME_SHOW=true

export MANPATH="/usr/local/man:$MANPATH"

export LANG=en_US.UTF-8
export LC_ALL=$LANG

export HISTCONTROL=ignoreboth
export HISTSIZE=10000
export HISTFILESIZE=$HISTSIZE

export EDITOR=nvim
export GIT_EDITOR=$EDITOR
export PKG_CONFIG_PATH="$HOME/.local/lib/pkgconfig:$HOME/.local/share/pkgconfig:/usr/local/lib/pkgconfig"
export GEM_HOME=$HOME/.gem
export PATH="$GEM_HOME/bin:$PATH"

# Golang
export GOPATH=$HOME/.go
export PATH="$GOPATH/bin:$PATH"

export GPG_TTY=$(tty)
export WINEARCH=win32

export DEVKITPRO=/opt/devkitpro
export DEVKITARM=$DEVKITPRO/devkitARM
export DEVKITPPC=$DEVKITPRO/devkitPPC
# export PATH="${DEVKITPPC}/bin:${DEVKITARM}/bin:${DEVKITPRO}/tools/bin:$PATH"

export PATH="$HOME/cross/bin:$PATH"

# Setup base16 themes
export BASE16_SHELL=$HOME/.config/base16-shell
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

# Setup nvm
export NVM_DIR=$HOME/.nvm
[ -s $NVM_DIR/nvm.sh ] && source $NVM_DIR/nvm.sh

# Do not freeze terminal on Ctrl-S
stty -ixon

# Do not share history
unsetopt share_history

# Disable annoying correction prompt
unsetopt correct_all

alias sudo='sudo '
alias yt-dl-mp3="youtube-dl -o '%(title)s.%(ext)s' -i -x --audio-quality 320K --audio-format mp3"
alias yt-dl-video="youtube-dl -iw -f 'bestvideo[height<=?1080,ext=mp4]+bestaudio[ext=m4a]/best'"
alias weather='curl wttr.in'
alias diff='diff -u -p -r -N --color=auto'
alias valgrind-full-check='valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes'
alias gcan!='git commit --amend --date now --reset-author'

git-check-merge() {
    local output="$(git merge $1 --no-ff --no-commit 2>&1)"

    if [[ "$output" == *"merge failed"* ]]; then
        echo "$output" | grep CONFLICT 2>/dev/null
        echo "Automatic merge failed" 2>/dev/null
    else
        echo "Automatic merge went well"
    fi

    git merge --abort # Return to previous state
}

gen-rsa-keypair() {
    openssl genpkey -algorithm RSA -out "$1" -pkeyopt rsa_keygen_bits:4096
    openssl rsa -pubout -in "$1" -out "$1.pub"
}

source $HOME/.zsh_platform

__update_log() {
    printf "\n 📦 \e[92mUpdating $1\e[0m\n"
}

update_omz_custom() {
    setopt pushdsilent

    pushd $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
    git pull
    popd

    pushd $ZSH_CUSTOM/themes/spaceship-prompt
    git pull
    popd

    unsetopt pushdsilent
}

update() {
    __update_log 'system packages'
    update_platform

    if hash yarn 2> /dev/null; then
        __update_log 'global node packages'
        yarn global upgrade
    fi


    if hash gem 2> /dev/null; then
        __update_log gems
        gem update
    fi


    if hash rustup 2> /dev/null; then
        __update_log rust
        rustup update
    fi

    __update_log 'oh-my-zsh custom stuff'
    update_omz_custom
}
