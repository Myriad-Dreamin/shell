#!/bin/bash

str_on="on"
str_off="off"
str_none=""

function set_dock_fixed() {
	if [[ "$1" = $str_on ]]
	then
		`gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed true`;
	elif [[ "$1" = $str_off ]]
	then
		`gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed false`;
	elif [[ "$1" = $str_none ]]
	then
		dock_state=`gsettings get org.gnome.shell.extensions.dash-to-dock dock-fixed`
		if [[ $dock_state == true ]]
		then
			`gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed false`;
		else
			`gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed true`;
		fi

	else
		echo "xdock: must with first parameter <string> [on|off|]";
	fi
}

set_dock_fixed

