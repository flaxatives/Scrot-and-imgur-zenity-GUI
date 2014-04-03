#!/bin/bash

# zscreen script by Christian Zucchelli (@Chris_Zeta) <thewebcha@gmail.com>
# modified by Marc Evangelista for use with sftp

if [ ! -d "$HOME/.zscreen" ]
then
mkdir ~/.zscreen
fi

cd ~
if [ ! -d "Screenshots" ]
then mkdir ~/Screenshots
fi

ans=$(zenity --width 350 --height 220 --list --text "Screenshot mode" --radiolist --column "Pick" --column "Options" TRUE "Selected Area... (click & drag mouse)" FALSE "Now" FALSE "With delay");

case $ans in

"Selected Area" )
    zenity --question --text "Do you want upload the screenshot?"
    if [ "$?" = "0" ]; then
        scrot -s '%Y-%m-%d--%s_$wx$h_scrot.png' -e 'sleep 1 & mv $f ~/Screenshots/ & zsftp ~/Screenshots/$f'
    else
        scrot -s '%Y-%m-%d--%s_$wx$h_scrot.png' -e 'sleep 1 & mv $f ~/Screenshots/'
    fi;;

"Window" ) 
    zenity --question --text "Do you want upload the screenshot?"
    if [ "$?" = "0" ]; then
        scrot -d 1 '%Y-%m-%d--%s_$wx$h_scrot.png' -e 'sleep 1 & mv $f ~/Screenshots/ & zsftp ~/Screenshots/$f'
    else
        scrot -d 1 '%Y-%m-%d--%s_$wx$h_scrot.png' -e 'sleep 1 & mv $f ~/Screenshots/'
    fi;;

"Fullscreen" ) d=$(zenity --entry --title="With delay" --text="Enter seconds of delay:" --entry-text "5")
    zenity --question --text "Do you want upload the screenshot?"
    if [ "$?" = "0" ]; then
        scrot -d "$d" '%Y-%m-%d--%s_$wx$h_scrot.png' -e 'sleep 1 & mv $f ~/Screenshots/ & zsftp ~/Screenshots/$f'
    else
        scrot -d "$d" '%Y-%m-%d--%s_$wx$h_scrot.png' -e 'sleep 1 & mv $f ~/Screenshots/'
    fi;;

esac
