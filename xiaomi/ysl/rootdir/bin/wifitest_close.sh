#!/vendor/bin/sh
rmmod wlan
sleep 1
setprop persist.sys.closewifi_L 0
exit 0

