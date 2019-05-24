#!/vendor/bin/sh
# launch_sniffer.sh

iface=$(getprop vendor.wlan.sniffer.iface)
channel=$(getprop vendor.wlan.sniffer.channel)
bandwidth=$(getprop vendor.wlan.sniffer.bandwidth)
vendor_file=$(getprop vendor.wlan.sniffer.vendor_file)
setprop vendor.wlan.sniffer.pid 0

insmod /vendor/lib/modules/qca_cld3_wlan.ko
sleep 1
ifconfig $iface down
sleep 3
echo 4 > /sys/module/wlan/parameters/con_mode
ifconfig $iface up
iw dev $iface set channel $channel $bandwidth
tcpdump -i $iface -w $vendor_file &
setprop vendor.wlan.sniffer.pid $!