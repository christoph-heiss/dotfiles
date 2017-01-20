#!/usr/bin/env bash

set -e

if ! which brew > /dev/null; then
	# install brew
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi


brew tap homebrew/dupes
brew tap homebrew/versions
brew tap homebrew/completions
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
brew install cloc lsusb valgrind truncate
brew install qemu node

# other tools
brew install youtube-dl ffmpeg
brew install unrar p7zip unzip
brew install nmap ssh-copy-id thefuck
brew install tree screenfetch cowsay htop
brew install --with-functions --universal sqlite3

# force-link keg-only formulas
brew link --force unzip sqlite


# brew cask
brew install brew-cask
brew tap caskroom/versions

brew cask install iterm2-beta
brew cask install qlmarkdown quicklook-json
brew cask install blender
brew cask install wireshark
brew cask install filezilla
brew cask install virtualbox virtualbox-extension-pack
brew cask install spotify vlc
brew cask install google-chrome
brew cask install dropbox
brew cask install sublime-text-dev
brew cask install hammerspoon

# clean up
brew cleanup -s --force --prune=0


# update pip
pip3 install --upgrade setuptools

# make python packages from brew importable.
mkdir -p $HOME/Library/Python/2.7/lib/python/site-packages
echo 'import site; site.addsitedir("/usr/local/lib/python2.7/site-packages")' >> $HOME/Library/Python/2.7/lib/python/site-packages/homebrew.pth

npm install -g gulp

echo '/usr/local/bin/bash' | sudo tee -a /etc/shells
sudo chsh -s /usr/local/bin/bash $USER

if hash xcode-select > /dev/null; then
        xcode-select --install || echo
fi

PORT_VER="MacPorts-2.3.4"
wget https://distfiles.macports.org/MacPorts/${PORT_VER}.tar.gz
tar -xf ${PORT_VER}.tar.gz
cd $PORT_VER
./configure
make
sudo make install
cd ..
rm -rf ${PORT_VER}.tar.gz ${PORT_VER}

export PATH="/opt/local/bin:$PATH"
sudo port selfupdate
sudo port install x86_64-elf-binutils x86_64-elf-gcc

# install rustc/cargo using rustup
curl https://sh.rustup.rs -sSf | sh

rustup run nightly-2016-08-01 cargo install --git https://github.com/murarth/rusti


sudo pmset -a sms 0
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true


mkdir -p ~/.hammerspoon
cp -va files/. $HOME/

cd ~/.hammerspoon
git clone https://github.com/nathancahill/anycomplete.git
