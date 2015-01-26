#!/bin/bash
xrandr --output LVDS1 --off
xrandr --output LVDS-0 --off
xrandr --newmode 1280x1024 109.00 1280 1386 1496 1712 1024 1027 1034 1063 -hsync +vsync
xrandr --addmode VGA1 1280x1024
xrandr --output VGA1 --mode 1280x1024
