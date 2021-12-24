#!/bin/sudo bash
while true
do
    if on_ac_power; then 
        echo 45 > /sys/class/backlight/amdgpu_bl0/brightness
    else
        echo 40 > /sys/class/backlight/amdgpu_bl0/brightness
    fi
    sleep 10                       ## wait 10 sec before repeating
done

