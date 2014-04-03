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

ans=$(zenity --width 350 --height 220 --list --text "Screenshot mode" --radiolist --column "Pick" --column "Options" TRUE "Window/Selected Area" FALSE "Fullscreen");

source $HOME/.zscreen/settings

scrot_flags=
if [[ "Window/Selected Area" == $ans ]]; then
    scrot_flags=-s
elif [[ "Fullscreen" == $ans ]]; then
    scrot_flags=-m
else
    return 2
fi

scrot $scrot_flags $IMG_FMT -e 'mv $f ~/Screenshots/ & zsftp ~/Screenshots/$f'

#case $ans in
#"Window/Selected Area" )
#    scrot_flags=-s
#    ;;
#
#"Fullscreen" ) 
#    ;;
#esac
