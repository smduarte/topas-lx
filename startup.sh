#!/bin/bash
echo "Starting..."

MOOSHAK=192.168.100.1

#sudo iptables -A OUTPUT -d $MOOSHAK -j ACCEPT
#sudo iptables -A OUTPUT -d 127.0.0.1/8 -j ACCEPT
#sudo iptables -A OUTPUT -j REJECT

xhost +
export DISPLAY=:0
su-exec topas:1001 /user-session.sh
