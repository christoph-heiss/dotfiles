#!/usr/bin/env bash

set -e

# install pacaur
sudo pacman -Syu --noconfirm
sudo pacman --noconfirm -S expac yajl
git clone --depth=1 https://github.com/rmarquis/pacaur
sudo cp pacaur/pacaur /usr/local/bin/
sudo cp pacaur/bash.completion /usr/share/bash-completion/completions/pacaur
sudo mkdir -p /etc/xdg/pacaur
sudo cp pacaur/config /etc/xdg/pacaur/
rm -rf pacaur


# Add sig for cower
gpg --recv-keys --keyserver hkp://pgp.mit.edu 1EB2638FF56C0C53

pacaur -Syu --aur --noconfirm
pacaur --noconfirm --noedit -S \
          scrot thefuck dropbox markdown speedometer htop nodejs yarn \
          texlive-most gimp screenfetch geary nmap avahi google-chrome \
          sublime-text-dev intel-ucode cups cups-filters ghostscript \
          ttf-meslo fontconfig vlc spotify cmake iotop perl-mime-tools \
          perl-net-smtp-ssl perl-authen-sasl qemu qemu-arch-extra \
          bash-completion cower xf86-input-mtrack-git

# Enable touchpad touchpad
sudo gpasswd -a christoph input
pacaur -Rns xorg-server-devel

pacaur -Qs hplib && pacaur -Rns hplib


# Enable scaling on login
cat > ~/.config/autostart/machine-setup.desktop <<EOF
[Desktop Entry]
Type=Application
Version=1.0
Name=machine-setup
Exec=/usr/local/sbin/setup-machine.sh
Terminal=false
X-Gnome-Autostart-enabled=true
EOF

sudo bash -c 'cat > /usr/local/sbin/setup-machine.sh <<EOF
#!/usr/bin/env bash

xrandr --output eDP1 --scale 1.5x1.5 --panning 3840x2400
EOF'

sudo chmod +x /usr/loca/sbin/setup-machine.sh


cp -va files/.bash_{aliases,colors,profile,utils} files/.bashrc files/.gitconfig $HOME/
