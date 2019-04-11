#!/vendor/bin/sh
rmmod wlan
sleep 1
setprop vendor.sys.ptt_socket_app 0
setprop vendor.sys.closewifi_L 0
exit 0

