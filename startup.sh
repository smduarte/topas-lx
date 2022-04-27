#!/bin/bash
echo "Starting..."

MOOSHAK=192.168.100.1

sudo iptables -A OUTPUT -d $MOOSHAK -j ACCEPT
sudo iptables -A OUTPUT -d 127.0.0.1/8 -j ACCEPT
sudo iptables -A OUTPUT -j REJECT

sudo deluser topas sudo
sudo rm -f /etc/sudoers.d/topas

mkdir -p $HOME/.local/share/applications 
mkdir -p $HOME/.config/pcmanfm/LXDE && cp /tmp/desktop-items-0.conf $HOME/.config/pcmanfm/LXDE/ 
rm -f $HOME/.local/share/applications/*.desktop && cp /tmp/*.desktop  $HOME/.local/share/applications/

export HOME=/home/topas
export USER=topas

/usr/bin/lxpanel --profile LXDE &
/usr/bin/pcmanfm --desktop --profile LXDE &

#exec /bin/tini -s -- /usr/bin/supervisord -n -c /etc/supervisor/supervisord.conf

exec /usr/bin/openbox
