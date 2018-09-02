#!/bin/bash

pgrep ibus-daemon > /dev/null 2>&1

if [ ! $? -eq 0 ]; then
    ibus-daemon --xim > /dev/null 2>&1 &

    setxkbmap -rules evdev -model pc101 -layout us
    setxkbmap -option ctrl:nocaps
fi

