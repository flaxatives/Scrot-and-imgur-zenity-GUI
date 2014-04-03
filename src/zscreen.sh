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
fi

scrot $scrot_flags '%Y-%m-%d--%s_$wx$h_scrot.png' -e 'sleep 1 & mv $f ~/Screenshots/ & zsftp ~/Screenshots/$f'

#case $ans in
#"Window/Selected Area" )
#    scrot_flags=-s
#    ;;
#
#"Fullscreen" ) 
#    ;;
#esac
