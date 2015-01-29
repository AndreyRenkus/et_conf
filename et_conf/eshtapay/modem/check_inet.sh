#!/bin/sh
#Script for checking Internet connection

#LOG="/var/log/check_inet.log"
SERVER="8.8.8.8"
PING="/bin/ping"
REBOOT="/sbin/reboot"
WVDIAL="/usr/bin/wvdial"
WVDIAL_ID=""
USB_RESET="/home/andrew/repos/et_conf/eshtapay/modem/usbreset"

ping_server() {
    ${PING} -q -c1 ${SERVER} >/dev/null 2>/dev/null
}

wvdial_restart() {
    killall -9 wvdial
    logger -p info -t inet "Starting WVDIAL..."
    ${WVDIAL} &
    return 0
}

usb_reset() {
logger -p info -t inet "Restarting USB power..."
killall -9 wvdial
#name="$(awk -F "=" '/Exec/ {print $2}' $file)"

LOGGING = ${USB_RESET} /dev/bus/usb/001/004
logger -p info -t inet "${LOGGING}"
return 0
}

logger -p info -t inet "============================================================="
logger -p info -t inet "Start of check INTERNET accessible"
ping_server
if [ $? -eq 0 ]; then
    logger -p info -t inet "The server ${SERVER} is pingable success!"
    exit 0
else
    logger -p err -t inet "FAIL! The server ${SERVER} is not pingable! --> Restarting WVDIAL..."
    wvdial_restart
    sleep 20
    ping_server
    if [ $? -eq 0 ]; then
        logger -p info -t inet  "The server ${SERVER} is pingable after WVDIAL restart!"
        exit 0
    else
        logger -p err -t inet  "Critical FAIL!! The server ${SERVER} is NOT pingable after WVDIAL restart!"
        usb_reset
    fi
fi
exit 0
