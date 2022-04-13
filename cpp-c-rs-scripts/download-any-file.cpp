#!/bin/env bash

M=`echo -ne "Regular\nTorrent" | dmenu -l 20 -p "choose the file type:"`

if [[ M -ne 'Regular' ]]
then
    cd ~/torrents
    torrent_file=`zenity --file-selection`
    zenity --progress --text="download may take longer please kindly wait \ndownloading...." --pulsate &
    aria2c -Umozilla/5.0 -x 10 -s 10 -c -T $torrent_file -d ~/Downloads/ --auto-file-renaming=false
    killall zenity
    zenity --progress --text="finished downloading" --percentage=100
else
    cd ~/downloadcatch
    file_to_download=`zenity --entry --text='enter the url to download:' --width=1000`
    zenity --progress --text="download may take longer please kindly wait \ndownloading...." --pulsate &
    aria2c -Umozilla/5.0 -x 10 -s 10 -c $file_to_download -d ~/Downloads/ --auto-file-renaming=false
    killall zenity
    zenity --progress --text="finished downloading" --percentage=100
fi
