#!/bin/bash

export TOPASLX=topas

[ ! "$(docker volume ls | grep home-$TOPASLX )" ] && \
        docker volume create home-$TOPASLX 


IMAGE=smduarte/topas-lx24
docker pull $IMAGE


export DISPLAY=:0
xhost +
Xephyr :3 -fullscreen &
#Xephyr :3  &

sleep 5
export DISPLAY=:3
xhost +
while :
do
       docker run -ti \
       --mount source=home-$TOPASLX,target=/home \
       -v /tmp/.X11-unix:/tmp/.X11-unix \
       -v /tmp:/tmp \
       --privileged \
       -e UID=$UID \
       -e DISPLAY \
       $IMAGE

       sleep 5
done
       
