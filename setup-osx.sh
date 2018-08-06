#!/usr/bin/env bash

set -e

WITH_GUI=y

source ./common.sh


if ! which brew > /dev/null; then
	# install brew
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi


brew tap caskroom/cask
brew tap jlhonora/lsusb

brew update
brew upgrade


# first, replace some tools with GNU versions
brew install --with-default-names gnu-sed make grep gnu-indent gnu-tar

# install build tools
brew install --with-pcre git
brew install pkg-config python3 wget
brew install autoconf autoconf-archive automake cmake

# shell-related
brew install bash bash-completion2
brew install open-completion brew-cask-completion pip-completion

# fix qemu install
brew install glib
brew link glib

# dev-tools
brew install cloc lsusb truncate
brew install qemu

# other tools
brew install youtube-dl ffmpeg colordiff
brew install unrar p7zip unzip
brew install nmap ssh-copy-id thefuck
brew install tree screenfetch cowsay htop
brew install --with-functions --universal sqlite3
brew install --with-nghttp2 --with-libssh2 curl

# force-link keg-only formulas
brew link --force unzip sqlite curl


# brew cask
brew tap caskroom/versions

brew cask install qlmarkdown quicklook-json
brew cask install blender
brew cask install wireshark
brew cask install filezilla
brew cask install spotify vlc
brew cask install google-chrome
brew cask install dropbox
brew cask install insomniax
brew cask install franz
brew cask install bettertouchtool

# clean up
brew cleanup -s --force --prune=0


# update pip
pip3 install --upgrade setuptools

# make python packages from brew importable.
mkdir -p $HOME/Library/Python/2.7/lib/python/site-packages
echo 'import site; site.addsitedir("/usr/local/lib/python2.7/site-packages")' >> $HOME/Library/Python/2.7/lib/python/site-packages/homebrew.pth

curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
curl -o- -L https://yarnpkg.com/install.sh | bash
nvm install node

generic_pre

echo '/usr/local/bin/bash' | sudo tee -a /etc/shells
sudo chsh -s /usr/local/bin/bash $USER

if hash xcode-select > /dev/null; then
        xcode-select --install || echo
fi

# install rustc/cargo using rustup
curl https://sh.rustup.rs -sSf | sh

source $HOME/.cargo/env
rustup default stable

mkdir ~/git
git clone git@github.com:jwilm/alacritty.git ~/git/alacritty
cd ~/git/alacritty
make app

cp -r target/release/osx/Alacritty.app /Applications/


sudo pmset -a sms 0
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Automatically loads keys into ssh-agent
mkdir -p ~/.ssh
cat >> ~/.ssh/config <<EOF
Host *
    AddKeysToAgent yes
    UseKeychain yes
    IdentityFile ~/.ssh/id_rsa
EOF


generic_post
