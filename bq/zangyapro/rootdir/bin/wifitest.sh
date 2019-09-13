#!/vendor/bin/sh
echo 5 > /sys/module/wlan/parameters/con_mode
setprop persist.sys.wifiFtmdaemon 1
ifconfig wlan0 up
setprop persist.sys.openwifi_L 0

exit 0

