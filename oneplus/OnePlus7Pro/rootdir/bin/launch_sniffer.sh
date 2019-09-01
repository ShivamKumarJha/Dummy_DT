#!/vendor/bin/sh
# launch_sniffer.sh

iface=$(getprop vendor.wlan.sniffer.iface)
channel=$(getprop vendor.wlan.sniffer.channel)
bandwidth=$(getprop vendor.wlan.sniffer.bandwidth)
vendor_dir=$(getprop vendor.wlan.sniffer.vendor_dir)
file=$(getprop vendor.wlan.sniffer.file)
setprop vendor.wlan.sniffer.pid 0

mkdir -p $vendor_dir
if [ ! $(echo $vendor_dir | grep "/$") ]
then
    vendor_dir=$vendor_dir/
fi
vendor_path=$vendor_dir$file

if [[ $(lsmod | grep "^wlan") == "" ]]
then
    insmod /vendor/lib/modules/qca_cld3_wlan.ko
    sleep 1
fi

ifconfig $iface down
sleep 3
echo 4 > /sys/module/wlan/parameters/con_mode
ifconfig $iface up

if [ $bandwidth -eq "80" ]
then
    iwpriv $iface setMonChan $channel 2
else
    bandwidth=HT$bandwidth
    iw dev $iface set channel $channel $bandwidth
fi

tcpdump -i $iface -w $vendor_path &
setprop vendor.wlan.sniffer.pid $!