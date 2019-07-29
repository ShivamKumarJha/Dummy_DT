#!/vendor/bin/sh
# terminate_sniffer.sh

iface=$(getprop vendor.wlan.sniffer.iface)
pid=$(getprop vendor.wlan.sniffer.pid)

kill -s SIGINT $pid
setprop vendor.wlan.sniffer.pid 0
ifconfig $iface down
sleep 3
echo 0 > /sys/module/wlan/parameters/con_mode
ifconfig $iface up