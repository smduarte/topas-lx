#!/bin/bash
echo "Starting..."

MOOSHAK=10.170.138.23

sudo iptables -A OUTPUT -p tcp -d $MOOSHAK -j ACCEPT
sudo iptables -A OUTPUT -p tcp -d 127.0.0.1/8 -j ACCEPT
sudo iptables -A OUTPUT -p tcp -j REJECT

xhost +
export DISPLAY=:0
chown -R $USER /home/topas
su-exec topas:1001 /user-session.sh
