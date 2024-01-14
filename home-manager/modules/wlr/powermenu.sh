#!/usr/bin/env bash

# ARGS:
# lock: command =  $1
# exit: command = $2
# Appear in the corner: bool = $3
# blackLock: command = $4
# restorebrightness: command = $5

if [ $3 = true ]; then
	in_corner="-l 3"
else
	in_corner=""
fi

op=$(echo -e " Poweroff\n Reboot\n Hibernate\n Suspend\n Lock\n◇ BlackScreen\n󰖙 RestoreBrightness\n Logout" | wofi -i --dmenu $in_corner | awk '{print tolower($2)}')

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
blackscreen)
	$4
	;;
restorebrightness)
	$5
	;;
esac
