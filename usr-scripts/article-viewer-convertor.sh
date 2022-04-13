#!/bin/env bash

zenity  --warning --text="DISCLAMER!!! \n Use the article for personal use only.\n Any illegal Activities shall not be held responsible by the developer" --ellipsize

cmd=`zenity --entry --text="enter any article url to download and convert for later viewing: " --width=1000`

if [[ $cmd != "" ]]
then
    cd ~/articles
    status=$?
    if [[ $status -eq 1 ]] 
    then
       cd ~
       mkdir articles
       cd articles
    fi
    aria2c -Umozilla/5.0 -x 10 -s 10 -c $cmd
    ls | zenity --text="all files in article directory" --list --column="files" &
    Name=`zenity --entry --text="enter unique name for your article: " --width=100`
    pandoc *.html -o "${Name}.docx"
    pandoc *.php -o "${Name}.docx"
    rm *.html
    rm *.php
    killall zenity
fi
