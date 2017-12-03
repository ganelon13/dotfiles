#!/usr/bin/env bash

# Usage: sudo ./link.sh [name] [path]
#  		 sudo ./link.sh mongochef /home/pk/programs/mongochef/bin/mongochef.sh

# [Desktop Entry]
# Name=mongochef
# Comment=
# GenericName=
# Keywords=
# Exec=sh "/home/thirteenth/programms/mongochef/bin/mongochef.sh" %f 
# Terminal=false
# Type=Application
# Icon=
# Path=
# Categories=
# NoDisplay=false

(
	echo "[Desktop Entry]";
	echo "Name=$1";
	echo "Comment=";
	echo "GenericName=";
	echo "Keywords=";
	echo "Exec=$2";
	echo "Terminal=false";
	echo "Type=Application";
	echo "Icon=$1";
	echo "Path=";
	echo "Categories=";
	echo "NoDisplay=false";
) > "/usr/share/applications/$1.desktop"

kate "/usr/share/applications/$1.desktop"
cp "/usr/share/applications/$1.desktop" "/home/$SUDO_USER/Рабочий стол/$1.desktop"
# rm "/usr/share/applications/$1.desktop"
