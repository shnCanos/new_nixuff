#!/usr/bin/env bash

# ARGS:
# lock: command =  $1
# exit: command = $2
# Appear in the corner: bool = $3

if [ $3 = true ]; then
	in_corner="-l 3"
else
	in_corner=""
fi

op=$(echo -e " Poweroff\n Reboot\n Hibernate\n Suspend\n Lock\n Logout" | wofi -i --dmenu $in_corner | awk '{print tolower($2)}')

case $op in
poweroff) ;&
reboot) ;&
hibernate) ;&
suspend)
	systemctl $op
	;;
lock)
	$1 # potentially unsafe
	;;
logout)
	$2 # potentially unsafe
	;;
esac
