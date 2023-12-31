#!/usr/bin/env bash

op=$(echo -e " Poweroff\n Reboot\n Hibernate\n Suspend\n Lock\n Logout" | wofi -i --dmenu -l 3 | awk '{print tolower($2)}')

case $op in
poweroff) ;&
reboot) ;&
hibernate) ;&
suspend)
	systemctl $op
	;;
lock)
	swaylock
	;;
logout)
	swaymsg exit
	;;
esac
