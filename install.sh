#!/bin/bash


#sudo apt-add-repository universe
sudo apt update

sudo apt install -y apt-transport-https
sudo apt install -y ca-certificates
sudo apt install -y curl
sudo apt install -y software-properties-common
sudo apt install -y git
sudo apt install -y intel-microcode
sudo apt install -y xserver-xorg-video-intel
sudo apt install -y mesa-utils
sudo apt install -y mesa-utils-extra
sudo apt install -y xorg
sudo apt install -y #xserver-xorg
sudo apt install -y #x11-xserver-utils
sudo apt install -y ubuntu-drivers-common
sudo apt install -y fonts-ubuntu
sudo apt install -y lxappearance
sudo apt install -y gtk-chtheme
sudo apt install -y qt4-qtconfig
sudo apt install -y slim
sudo apt install -y wicd
sudo apt install -y zsh
sudo apt install -y rxvt-unicode
sudo apt install -y scrot
sudo apt install -y imagemagick
sudo apt install -y xautolock
sudo apt install -y pasystray
sudo apt install -y fonts-powerline
sudo apt install -y fonts-font-awesome
sudo apt install -y nfs-common
sudo apt install -y ranger
sudo apt install -y xbacklight
sudo apt install -y arandr
sudo apt install -y rofi
sudo apt install -y vlc
sudo apt install -y feh
sudo apt install -y mosquitto-clients
sudo apt install -y pavucontrol
sudo apt install -y aptitude
sudo apt install -y wicd-curses
sudo apt install -y htop
sudo apt install -y qbittorrent
sudo apt install -y thunar
sudo apt install -y gimp
sudo apt install -y build-essential
sudo apt install -y automake
sudo apt install -y autoconf
sudo apt install -y bluez
sudo apt install -y cups
sudo apt install -y cups-client
sudo apt install -y cups-filters
sudo apt install -y sane
sudo apt install -y sane-utils
sudo apt install -y libsane-extras
sudo apt install -y xsane
sudo apt install -y libdbus-1-dev
sudo apt install -y network-manager
sudo apt install -y python3-pip
sudo apt install -y python3-setuptools
sudo apt install -y python-gobject
sudo apt install -y python3-yaml
sudo apt install -y libgio2.0
sudo apt install -y gobject-introspection
sudo apt install -y libgtk2.0-0
sudo apt install -y libnotify4
sudo apt install -y gettext
sudo apt install -y gir1.2-notify-0.7
sudo apt install -y libnotify-bin
sudo apt install -y libx11-dev
sudo apt install -y libxinerama-dev
sudo apt install -y libxrandr-dev
sudo apt install -y libxss-dev
sudo apt install -y libglib2.0-dev
sudo apt install -y libpango1.0-dev
sudo apt install -y libgtk-3-dev
sudo apt install -y libxdg-basedir-dev
sudo apt install -y libnotify-dev
sudo apt install -y libxml2:i386
sudo apt install -y libpulse-dev

# system-config-printer-gnome
# indicator-printers

# hplip
# printer-driver-brlaser
# printer-driver-c2esp
# printer-driver-foo2zjs
# printer-driver-gutenprint
# printer-driver-hpcups
# printer-driver-min12xxw
# printer-driver-pnm2ppa
# printer-driver-postscript-hp
# printer-driver-ptouch
# printer-driver-pxljr
# printer-driver-sag-gdi
# printer-driver-splix


# chrome
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
sudo apt-get update
sudo apt-get install google-chrome-stable

# i3
/usr/lib/apt/apt-helper download-file http://debian.sur5r.net/i3/pool/main/s/sur5r-keyring/sur5r-keyring_2018.01.30_all.deb keyring.deb SHA256:baa43dbbd7232ea2b5444cae238d53bebb9d34601cc000e82f11111b1889078a
sudo dpkg -i ./keyring.deb
sudo sh -c 'echo "deb http://debian.sur5r.net/i3/ $(grep '^DISTRIB_CODENAME=' /etc/lsb-release | cut -f2 -d=) universe" >> /etc/apt/sources.list.d/sur5r-i3.list'
sudo apt update
sudo apt install i3 i3lock i3blocks i3status

# vs code
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt-get update
sudo apt-get install code

# dropbox
#sudo apt-key adv --keyserver pgp.mit.edu --recv-keys 1C61A2656FB57B7E4DE0F4C1FC918B335044912E
#sudo sh -c 'echo "deb http://linux.dropbox.com/ubuntu $(grep '^DISTRIB_CODENAME=' /etc/lsb-release | cut -f2 -d=) main " >> /etc/apt/sources.list.d/dropbox.list'

# python and pip
#sudo apt install -y python3-minimal python3-pip
#pip install psutil netifaces requests power dbus i3ipc sensors
pip install git+https://github.com/GeorgeFilipkin/pulsemixer.git

# oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# docker ce
sudo groupadd docker
sudo usermod -aG docker $USER
sudo apt -y install  
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt -y install docker-ce

# docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# themes
mkdir -p ~/work/personal
cd ~/work/personal/
git clone https://github.com/tliron/install-gnome-themes
cd install-gnome-themes
./install-requirements-debian
./install-gnome-themes

