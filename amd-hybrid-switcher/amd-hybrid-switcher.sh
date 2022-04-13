#!/bin/env bash
echo "##################################################################################"
echo "#########               WELCOME TO AMD HYBRID SWITCHER                 ###########"
echo "##################################################################################"

sudo rm -rf /etc/X11/xorg.conf.d/*

read -p "which gpu do you want to switch to: /n 1)Amdgpu /n 2)Radeon /n 3)Intel /n 4)Nvidia /n 5)Quit" answer
if [[ $answer == "1" ]]
then
    echo "switching to Amdgpu"
    sudo rm -rf /etc/X11/xorg.conf.d/*
    sudo cp 20-amdgpu.conf /etc/X11/xorg.conf.d/
elif [[ $answer == "2" ]]
then
    echo "switching to Radeon"
    sudo rm -rf /etc/X11/xorg.conf.d/*
    sudo cp 20-radeon.conf /etc/X11/xorg.conf.d/
elif [[ $answer == "3" ]]
then
    echo "switching to Intel"
    sudo rm -rf /etc/X11/xorg.conf.d/*
    sudo cp 20-intel.conf /etc/X11/xorg.conf.d/
elif [[ $answer == "4" ]]
then
    echo "switching to Nvidia"
    sudo rm -rf /etc/X11/xorg.conf.d/*
    sudo cp 20-nvidia.conf /etc/X11/xorg.conf.d/
else
    echo "terminated"
fi

echo "##################################################################################"
echo "#########                      REBOOTING YOUR SYSTEM                   ###########"
echo "##################################################################################"

read -p "Do you want reboot your system [Y/N]: " answer
if [[ $answer == "Y" or $answer == "y" ]]
then
    echo "rebooting"
    reboot
else
    echo "please make sure to reboot your system!"
fi    


