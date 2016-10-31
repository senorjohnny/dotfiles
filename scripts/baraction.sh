#!/usr/bin/bash
# baraction.sh script for spectrwm status bar

Clock() {
	DATETIME=$(date "+%d.%m.%Y %H:%M")
	echo -n "$DATETIME"
}
Battery() {
	BATPERC=$(acpi --battery | cut -d, -f2)
	echo "Battery: [$BATPERC]"
}
Network() {
	NETPERC=$(cat /proc/net/wireless | grep wlo1 | sed -n 's/.*\: \([0-9]\+\)[ ]\+\([0-9]\+\)\..*/\2/p')
	SSID=$(iwgetid -r)
	echo "$SSID [$NETPERC%]"
}
Volume() {
	VOLPERC=$(amixer | head -5 | tail -1 | sed -n 's/.*\[\([0-9]\+\)%\].*/\1/p')
	echo "Volume: [$VOLPERC%]"
}

SLEEP_SEC=2
while :; do
	printf "%170s\n" "| $(Volume) | $(Network) | $(Battery) | $(Clock)"
	sleep $SLEEP_SEC
done
	
