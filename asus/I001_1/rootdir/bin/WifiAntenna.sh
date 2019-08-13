#!/system/bin/sh
wifiantennamode=`getprop vendor.asus.wifiantennamode`
Wifion=`getprop wlan.driver.status`

log -t WifiAntenna enter wifiantennamode=$wifiantennamode Wifion=$Wifion

if [ "$wifiantennamode" == "0" ] ; then
    echo 1000 > /sys/module/icnss/parameters/do_wifi_antenna_switch
    cat /sys/kernel/debug/icnss/stats
    log -t WifiAntenna wifiantennamode 0
elif [ "$wifiantennamode" == "1" ]; then
    echo 1111 > /sys/module/icnss/parameters/do_wifi_antenna_switch
    cat /sys/kernel/debug/icnss/stats
    log -t WifiAntenna wifiantennamode 1
elif [ "$wifiantennamode" == "2" ]; then
    echo 1100 > /sys/module/icnss/parameters/do_wifi_antenna_switch
    cat /sys/kernel/debug/icnss/stats
    log -t WifiAntenna wifiantennamode 2
elif [ "$wifiantennamode" == "3" ]; then
    echo 1100 > /sys/module/icnss/parameters/do_wifi_antenna_switch
    cat /sys/kernel/debug/icnss/stats
    log -t WifiAntenna wifiantennamode 3
elif [ "$wifiantennamode" == "4" ]; then
    echo 0100 > /sys/module/icnss/parameters/do_wifi_antenna_switch
    cat /sys/kernel/debug/icnss/stats
    log -t WifiAntenna wifiantennamode 4
else
    echo 1000 > /sys/module/icnss/parameters/do_wifi_antenna_switch
    cat /sys/kernel/debug/icnss/stats
    log -t WifiAntenna wifiantennamode 0
fi
