#!/bin/bash

LOGFILE=/tmp/my-desktop-install.log

declare -a MY_PACKAGES=(
"apt-transport-https"
"ca-certificates"
"curl"
"software-properties-common"
"git"
"intel-microcode"
"xserver-xorg-video-intel"
"mesa-utils"
"mesa-utils-extra"
"xorg"
"ubuntu-drivers-common"
"fonts-ubuntu"
"lxappearance"
"gtk-chtheme"
"qt4-qtconfig"
"slim"
"zsh"
"rxvt-unicode"
"scrot"
"imagemagick"
"xautolock"
"pasystray"
"fonts-powerline"
"fonts-font-awesome"
"nfs-common"
"ranger"
"xbacklight"
"arandr"
"rofi"
"vlc"
"feh"
"mosquitto-clients"
"pavucontrol"
"aptitude"
"htop"
"qbittorrent"
"thunar"
"gimp"
"build-essential"
"automake"
"autoconf"
"bluez"
"cups"
"cups-client"
"cups-filters"
"sane"
"sane-utils"
"libsane-extras"
"xsane"
"libdbus-1-dev"
"network-manager"
"python3-pip"
"python3-setuptools"
"python-gobject"
"python3-yaml"
"libgio2.0"
"gobject-introspection"
"libgtk2.0-0"
"libnotify4"
"gettext"
"gir1.2-notify-0.7"
"libnotify-bin"
"libx11-dev"
"libxinerama-dev"
"libxrandr-dev"
"libxss-dev"
"libglib2.0-dev"
"libpango1.0-dev"
"libgtk-3-dev"
"libxdg-basedir-dev"
"libnotify-dev"
"libxml2:i386"
"libpulse-dev"
"meson"
"ninja-build"
"pkg-config"
"parallel"
"ruby-sass"
"sassc"
"optipng"
"inkscape"
"libgtk-3-dev"
"libgdk-pixbuf2.0-dev"
"libglib2.0-dev"
"libglib2.0-bin"
"libxml2-utils"
"librsvg2-dev"
"gnome-themes-standard"
"gtk2-engines-murrine"
"gtk2-engines-pixbuf"
"fonts-roboto-hinted"
"fonts-noto-hinted"
)

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

install_package() {
    PACKAGE_NAME=$1
    echo "====================== Installing $PACKAGE_NAME ======================"
    apt-get install -y $PACKAGE_NAME
    echo "=================== Done Installing $PACKAGE_NAME ===================="
    
}

if [ "$EUID" -ne 0 ]; then
  echo "Need root permission to run, run as \"sudo $0\""
  exit
fi

{
#echo "============================= Adding keys ============================"
#curl -fsSL http://apt.pop-os.org/proprietary/dists/bionic/Release.gpg | apt-key add -

echo "========================= Adding repositories ========================"
add-apt-repository "deb http://us.archive.ubuntu.com/ubuntu/ bionic main restricted universe multiverse"
add-apt-repository "deb http://us.archive.ubuntu.com/ubuntu/ bionic-updates main restricted universe multiverse"
add-apt-repository "deb http://us.archive.ubuntu.com/ubuntu/ bionic-security main restricted universe multiverse"
add-apt-repository "deb http://us.archive.ubuntu.com/ubuntu/ bionic-backports main restricted universe multiverse"
#add-apt-repository "deb http://apt.pop-os.org/proprietary bionic main"
add-apt-repository ppa:system76/pop
echo "======================= Done Adding repositories ======================"

#apt-get update

for p in "${MY_PACKAGES[@]}"
do
   install_package "$p"
done

# chrome
echo "========================= Installing Google Chrome ========================"
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
apt-get update
install_package google-chrome-stable
echo "====================== Done Installing Google Chrome ======================"

# i3
echo "============================== Installing i3 =============================="
/usr/lib/apt/apt-helper download-file http://debian.sur5r.net/i3/pool/main/s/sur5r-keyring/sur5r-keyring_2018.01.30_all.deb keyring.deb SHA256:baa43dbbd7232ea2b5444cae238d53bebb9d34601cc000e82f11111b1889078a
dpkg -i ./keyring.deb
sh -c 'echo "deb http://debian.sur5r.net/i3/ $(grep '^DISTRIB_CODENAME=' /etc/lsb-release | cut -f2 -d=) universe" >> /etc/apt/sources.list.d/sur5r-i3.list'
apt update
install_package i3
install_package i3lock
install_package i3blocks
install_package i3status
echo "============================ Done Installing i3 ==========================="

# vs code
echo "============================ Installing vscode ============================"
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
apt-get update
install_package code
echo "========================== Done Installing vscode ========================="

# python and pip
#"python3-minimal python3-pip
#pip install psutil netifaces requests power dbus i3ipc sensors
echo "========================== Installing pulsemixer =========================="
pip install git+https://github.com/GeorgeFilipkin/pulsemixer.git
echo "======================= Done Installing pulsemixer ========================"

# docker ce
echo "============================ Installing docker ============================"
groupadd docker
usermod -aG docker $USER
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
install_package docker-ce
echo "========================== Done Installing docker ========================="

# docker-compose
echo "======================== Installing docker-compose ========================"
curl -L "https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
echo "====================== Done Installing docker-compose ====================="

# themes
echo "============================ Installing themes ============================"
mkdir -p ~/work/personal
cd ~/work/personal/
git clone https://github.com/tliron/install-gnome-themes
cd install-gnome-themes
./install-gnome-themes
echo "========================== Done Installing themes ========================="

# dropbox
echo "Next steps"
echo "1) install dropbox from its website."
#sudo apt-key adv --keyserver pgp.mit.edu --recv-keys 1C61A2656FB57B7E4DE0F4C1FC918B335044912E
#sudo sh -c 'echo "deb http://linux.dropbox.com/ubuntu $(grep '^DISTRIB_CODENAME=' /etc/lsb-release | cut -f2 -d=) main " >> /etc/apt/sources.list.d/dropbox.list'

echo "2) Install wicd and wicd clients:"
echo "sudo apt install -y wicd wicd-curses"

echo "3) Install ohmyzsh:"
echo "sh -c \"\$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)\""

echo "4) Still todo: dotfiles and scripts"
} >> $LOGFILE 2>&1
