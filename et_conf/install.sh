#!/bin/sh
USER=eshtapay
HOME_DIR=/home/$USER
ETC_DIR=/etc
INIT_DIR=/etc/init
PACKAGES="wget dbus xorg openbox firefox rungetty psmisc mc feh wvdial xinput-calibrator usb-modeswitch"

echo panda > /etc/hostname

echo "127.0.0.1 localhost" > /etc/hosts
echo "127.0.1.1 panda" > /etc/hosts

echo 'deb http://archive.ubuntu.com/ubuntu trusty universe' >> /etc/apt/sources.list
echo 'deb http://archive.ubuntu.com/ubuntu trusty-updates universe' >> /etc/apt/sources.list
apt-get -y update
apt-get -y --force-yes install $PACKAGES
apt-get autoclean

useradd eshtapay -m -s /bin/bash
passwd eshtapay

sudo -u $USER cp .profile $HOME_DIR
sudo -u $USER mkdir $HOME_DIR/.config
sudo -u $USER cp -r openbox/ $HOME_DIR/.config
sudo -u $USER mkdir $HOME_DIR/Pictures
sudo -u $USER cp eshtapay.jpg $HOME_DIR/Pictures
sudo -u $USER crontab crontabs/eshtapay

cp etc/* $ETC_DIR
cp init/* $INIT_DIR
cp -r eshtapay/ /usr/local
cp -r eshtapay-terminals/ /usr/local
chown -R root:eshtapay /usr/local/eshtapay-terminals
chmod -R g+w /usr/local/eshtapay-terminals

mkdir /usr/lib/jvm
cp -r jre1.8.0/ /usr/lib/jvm
update-alternatives --install "/usr/bin/java" "java" "/usr/lib/jvm/jre1.8.0/bin/java" 1
