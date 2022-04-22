#!/bin/bash
echo "Starting..."

mkdir -p $HOME/.config/pcmanfm/LXDE && cp /tmp/desktop-items-0.conf $HOME/.config/pcmanfm/LXDE/ 

#setxkbmap -model macbook79 -layout pt


#for file in /etc/supervisor/conf.d/*; do
#	sed -i "s|%USER%|$USER|" $file
#	sed -i "s|%HOME%|$HOME|" $file
#	sed -i "s|%DISPLAY%|$DISPLAY|" $file	
#done

#chmod 777 /var/run/docker.sock

mkdir -p $HOME/.local/share/applications 
rm -f $HOME/.local/share/applications/*.desktop && cp /tmp/*.desktop  $HOME/.local/share/applications/


/usr/bin/lxpanel --profile LXDE &
/usr/bin/pcmanfm --desktop --profile LXDE &

#exec /bin/tini -s -- /usr/bin/supervisord -n -c /etc/supervisor/supervisord.conf

exec /usr/bin/openbox
