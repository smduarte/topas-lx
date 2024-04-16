#!/bin/bash

mkdir -p $HOME/.local/share/applications 
mkdir -p $HOME/.config/pcmanfm/LXDE && cp /tmp/desktop-items-0.conf $HOME/.config/pcmanfm/LXDE/ 
rm -f $HOME/.local/share/applications/*.desktop && cp /tmp/*.desktop  $HOME/.local/share/applications/

export HOME=/home/topas
export USER=topas

/usr/bin/lxpanel --profile LXDE &
/usr/bin/pcmanfm --desktop --profile LXDE &

setxkbmap pt
exec /usr/bin/openbox --replace
