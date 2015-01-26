#!/bin/sh
/usr/bin/wget --spider 127.0.0.1:8091
if [ "$?" -eq 0 ]; then
    browser=$(ps -A|grep firefox|wc -l)
    if [ $browser -eq 0 ]; then
	/usr/bin/firefox --display=:0 -private 127.0.0.1:8091 &
    fi
else
    /usr/bin/pkill  firefox
fi
