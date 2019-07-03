#
# ~/.zshrc
#


# If not running interactively, do nothing
[[ $- != *i* ]] && return

export PATH="/var/lib/snapd/snap/bin:/data/go/bin:$HOME/.yarn/bin:$HOME/.cargo/bin:$HOME/local/bin:$HOME/.gems/bin:$PATH"
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
    command-not-found
    docker
    docker-compose
    git
    git-extras
    kubectl
    minikube
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


export MANPATH="/usr/local/man:$MANPATH"

export LANG=en_US.UTF-8
export LC_ALL=$LANG

export HISTCONTROL=ignoreboth
export HISTSIZE=10000
export HISTFILESIZE=$HISTSIZE

export EDITOR=nvim
export GIT_EDITOR=$EDITOR
export PKG_CONFIG_PATH=$HOME/local/lib/pkgconfig:$HOME/local/lib64/pkgconfig:$HOME/local/share/pkgconfig
export GEM_HOM=$HOME/.gems
export GOPATH=/data/go

export GPG_TTY=$(tty)

# Setup base16 themes
export BASE16_SHELL=$HOME/.config/base16-shell
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

# Set current terminal theme
base16_material

# Setup nvm
export NVM_DIR=$HOME/.nvm
[ -s $NVM_DIR/nvm.sh ] && source $NVM_DIR/nvm.sh

# Do not freeze terminal on Ctrl-S
stty -ixon

# Do not share history
unsetopt share_history

alias sudo='sudo '
alias yt-dl="youtube-dl -o '%(title)s.%(ext)s' -i -x --audio-quality 320K --audio-format mp3"
alias weather='curl wttr.in'
alias diff='diff -u --color=always'

git-check-merge() {
    git merge $1 --no-ff --no-commit
    git merge --abort # Return to previous state
}


source $HOME/.zsh_platform


__update_log() {
    printf "\n 📦 \e[92mUpdating $1\e[0m\n"
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
}
