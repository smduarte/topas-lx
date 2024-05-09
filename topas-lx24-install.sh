#!/bin/bash

wget -O - https://raw.githubusercontent.com/smduarte/topas-lx/main/user > .config/dconf/user
wget -O - https://raw.githubusercontent.com/smduarte/topas-lx/main/Xmodmap > .Xmodmap
wget -O - https://raw.githubusercontent.com/smduarte/topas-lx/main/dconf-keyboard-bindings.dconf | dconf load /

wget -O vm-topas-lx24.sh https://raw.githubusercontent.com/smduarte/topas-lx/main/vm-topas-lx24.sh

echo "Logout so changes take effect!!!!"
