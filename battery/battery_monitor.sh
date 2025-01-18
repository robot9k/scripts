#!/bin/bash

export DISPLAY=:0
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/1000/bus"

battery_capacity=$(cat /sys/class/power_supply/BAT0/capacity)

if [ "$battery_capacity" -lt 10 ]; then
    if [ ! -f /tmp/battery_10_notified ]; then
        notify-send -u critical "Battery less than 10 percent"
        touch /tmp/battery_10_notified
    fi
elif [ "$battery_capacity" -lt 20 ]; then
    if [ ! -f /tmp/battery_20_notified ]; then
        notify-send "Battery less than 20 percent"
        touch /tmp/battery_20_notified
    fi
else
    rm -f /tmp/battery_10_notified /tmp/battery_20_notified
fi
