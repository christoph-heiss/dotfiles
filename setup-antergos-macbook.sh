#!/usr/bin/env bash

set -e

WITH_GUI=y

source ./common.sh


arch_generic_pre

yay -S $YAY_OPTIONS --needed xf86-input-mtrack-git

generic_pre


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

sudo chmod +x /usr/local/sbin/setup-machine.sh


arch_generic_post
generic_post
