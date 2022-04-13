#!/bin/env bash

while :
do
    N=`acpi | cut -d ' ' -f4 | cut -d ',' -f1 | cut -d '%' -f1`
    M=`acpi | cut -d ' ' -f3 | cut -d ',' -f1`
    if [[ $N -le "30" && $M != "Charging" ]]
    then
        zenity --info --text="battery running low \n please plug in your charger" --icon-name="bell" --ellipsize
    elif [[ $N -ge "85" && $M == "Charging" ]]
    then
        zenity --info --text="battery is full \n please plug out your charger" --icon-name="bell" --ellipsize
    fi
    sleep 60
done
