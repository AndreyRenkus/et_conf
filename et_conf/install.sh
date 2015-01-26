#!/bin/sh
USER=eshtapay
HOME_DIR=/home/$USER
ETC_DIR=/etc
INIT_DIR=/etc/init

sudo -u $USER cp .profile $HOME_DIR
sudo -u $USER mkdir $HOME_DIR/.config
sudo -u $USER cp openbox/ $HOME_DIR/.config
sudo -u $USER mkdir $HOME/Pictures
sudo -u $USER cp eshtapay.jpg $HOME/Pictures
sudo -u $USER crontab crontabs/eshtapay

cp etc/* $ETC_DIR
cp init/* $INIT_DIR
cp -r eshtapay/ /usr/local
cp -r eshtapay-terminals/ /usr/local

mkdir /usr/lib/jvm
cp jre1.8.0_25/ /usr/lib/jvm
