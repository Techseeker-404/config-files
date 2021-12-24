#!/bin/sudo bash
if on_ac_power; then 
    echo 48 > /sys/class/backlight/amdgpu_bl0/brightness
#else
#    echo 40 > /sys/class/backlight/amdgpu_bl0/brightness
fi


