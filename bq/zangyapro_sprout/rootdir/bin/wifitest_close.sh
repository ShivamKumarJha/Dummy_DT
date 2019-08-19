#!/vendor/bin/sh
setprop persist.sys.wifiFtmdaemon 0
echo 0 > /sys/module/wlan/parameters/con_mode
sleep 3
ifconfig wlan0 down
exit 0
