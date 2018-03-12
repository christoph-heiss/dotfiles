#!/usr/bin/env bash

set -e

sudo pacman -S pacaur

pacaur -Syu --aur --noconfirm
pacaur --noconfirm --noedit -S \
          scrot thefuck dropbox markdown speedometer htop nodejs yarn \
          texlive-most gimp screenfetch geary nmap avahi google-chrome \
          intel-ucode cups cups-filters ghostscript ttf-meslo fontconfig \
          vlc spotify cmake iotop perl-mime-tools perl-net-smtp-ssl \
          perl-authen-sasl qemu qemu-arch-extra bash-completion \
          xf86-input-mtrack-git vim tmux


pacaur -Qs hplib && pacaur -Rns hplib
pacaur -Scc

yarn global add gulp

# Enable touchpad
sudo gpasswd -a christoph input


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


git clone --recurse-submodules -j4 https://github.com/christoph-heiss/vimfiles.git $HOME/.vim
ln -s $HOME/.vim/vimrc $HOME/.vimrc

git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell

cp -va files/.bash_{aliases,colors,profile,utils} files/.{bashrc,gitconfig,tmux.conf} $HOME/
