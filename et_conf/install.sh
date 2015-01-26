#!/bin/sh
USER=eshtapay
HOME_DIR=/home/$USER
INIT_DIR=/etc/init

sudo -u $USER cp .profile $HOME_DIR
sudo -u $USER mkdir $HOME_DIR/.config
sudo -u $USER cp openbox/ $HOME_DIR/.config
sudo -u $USER mkdir $HOME/Pictures
sudo -u $USER cp eshtapay.jpg $HOME/Pictures

cp init/* $INIT_DIR
cp -r eshtapay/ /usr/local