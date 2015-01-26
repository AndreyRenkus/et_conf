#!/bin/sh
CONF=/etc/wvdial.conf
MTS=/usr/local/eshtapay/modem/wvdialMTS.conf
KIEVSTAR=/usr/local/eshtapay/modem/wvdialKIEVSTAR.conf

MODE="$1"
    case $MODE in
    mts)
    cp -rf $MTS $CONF
    notify-send "MTS profile is selected."
    ;;
    kievstar)
    cp -rf $KIEVSTAR $CONF
    notify-send "KIEVSTAR profile is selected."
    ;;
    esac
