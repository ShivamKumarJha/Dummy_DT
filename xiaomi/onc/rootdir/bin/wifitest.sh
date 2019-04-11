#!/vendor/bin/sh
rmmod wlan
sleep 1
insmod /vendor/lib/modules/pronto_wlan.ko con_mode=5
sleep 1
setprop vendor.sys.ptt_socket_app 1
setprop vendor.sys.openwifi_L 0
exit 0

