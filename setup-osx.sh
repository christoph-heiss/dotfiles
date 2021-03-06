#!/usr/bin/env bash

set -e
set -u

if ! which brew > /dev/null; then
    # install brew
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi


brew tap caskroom/cask
brew tap caskroom/versions
brew tap jlhonora/lsusb

brew update
brew upgrade


# first, replace some tools with GNU versions
brew install gnu-sed make grep gnu-tar diffutils

# install build tools
brew install --with-pcre git
brew install pkg-config python wget
brew install autoconf autoconf-archive automake cmake

# shell-related
brew install zsh zsh-autosuggestions zsh-completions
brew install open-completion brew-cask-completion pip-completion
brew install tmux tmux-mem-cpu-load

# fix qemu install
brew install glib
brew link glib

# dev-tools
brew install cloc lsusb truncate
brew install qemu

# other tools
brew install youtube-dl ffmpeg colordiff
brew install unrar p7zip unzip
brew install nmap ssh-copy-id rsync
brew install tree screenfetch cowsay htop bat
brew install --with-functions --universal sqlite3
brew install --with-nghttp2 --with-libssh2 curl

# force-link keg-only formulas
brew link --force unzip sqlite

# GUI applications
brew cask install quicklook-json
brew cask install wireshark
brew cask install firefox-nightly
brew cask install spotify vlc
brew cask install bettertouchtool || true
brew cask isntall alt-tab

# Install terminal font
brew install homebrew/cask-fonts/font-roboto-mono-for-powerline

# clean up
brew cleanup -s --prune=0

if hash xcode-select > /dev/null; then
    xcode-select --install || echo
fi

# Install rust[up] and cargo
if ! which brew > /dev/null; then
    curl https://sh.rustup.rs -sSf | sh

    source $HOME/.cargo/env
    rustup default stable
fi

sudo pmset -a sms 0
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Make keyboard repeat faster
defaults write -g InitialKeyRepeat -int 12
defaults write -g KeyRepeat -int 1

# Automatically loads keys into ssh-agent
mkdir -p ~/.ssh
cat >> ~/.ssh/config <<EOF
Host *
    AddKeysToAgent yes
    UseKeychain yes
    IdentityFile ~/.ssh/id_rsa
EOF

./common.sh
cp -vp files/.zsh_platform_darwin $HOME/.zsh_platform

mkdir -p $HOME/Library/Application\ Support/amp
cp -vp files/amp.yml $HOME/Library/Application\ Support/amp/config.yml
