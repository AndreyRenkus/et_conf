#!/bin/sh
#Script for checking Internet connection

SERVER="8.8.8.8"
#SERVER="10.10.10.10"
PING="/bin/ping"
REBOOT="/sbin/reboot"
WVDIAL="/usr/bin/wvdial"
WVDIAL_ID=""
USB_RESET="/usr/local/bin/usbreset"

ping_server() {
    ${PING} -q -c1 ${SERVER} >/dev/null 2>/dev/null
    PINGSTATUS=$?
    if [ ${PINGSTATUS} -eq 0 ]; then
    	logger -p info -t inet "Check inet: STATUS - SUCCESS"
    else
	logger -p info -t inet "Check inet: STATUS - FAIL"
    fi
    return ${PINGSTATUS}
}

wvdial_restart() {
    if ls /dev | grep USB0; then
	killall -9 wvdial
	logger -p info -t inet "Starting WVDIAL..."
	${WVDIAL} &
	sleep 20
    else
	logger -p info -t inet "USB modem is absent or not ready"
	logger -p info -t inet "<==="
	exit 1
    fi
    return 0
}

usb_reset() {
    logger -p info -t inet "Restarting USB power..."
    killall -9 wvdial
    BUS=`lsusb | grep 12d1:1506 | awk ' {print $2} '`
    DEVICE=`lsusb | grep 12d1:1506 | awk ' {print $4} ' | sed 's/://g'`
    if [ ${BUS} -a ${DEVICE} ]; then
    	LOGGING=`${USB_RESET} /dev/bus/usb/${BUS}/${DEVICE}`
    	logger -p info -t inet "${LOGGING}"
    else
    	logger -p info -t inet "USB modem not found"
    fi
    return 0
}

logger -p info -t inet "===>"
ping_server
if [ $? -ne 0 ]; then
    wvdial_restart
    ping_server
    if [ $? -ne 0 ]; then
        usb_reset
	sleep 10
	wvdial_restart
	ping_server
    fi
fi
logger -p info -t inet "<==="
exit 0
