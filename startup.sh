#!/bin/bash
echo "Starting..."

MOOSHAK=192.168.100.1

sudo iptables -A OUTPUT -d $MOOSHAK -j ACCEPT
sudo iptables -A OUTPUT -d 127.0.0.1/8 -j ACCEPT
sudo iptables -A OUTPUT -j REJECT

#sudo deluser topas sudo
#sudo rm -f /etc/sudoers.d/topas

exec su topas -c /user-session.h
