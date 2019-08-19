#!/system/bin/sh
Airplaneon=`getprop persist.vendor.radio.airplane_mode_on`
Wifion=`getprop wlan.driver.status`
Bton=`getprop vendor.bluetooth.status`
L13Aswitch=`getprop persist.vendor.L13Aswitch`

log -t Lain WifiL13A enter Airplaneon=$Airplaneon Wifion=$Wifion Bton=$Bton L13Aswitch=$L13Aswitch

if [ "$Airplaneon" == "1" ] ; then
    if [ "$Wifion" == "unloaded" ] && [ "$Bton" == "off" ] ; then
        echo 0 > /sys/module/icnss/parameters/do_antenna_switch
        cat /sys/kernel/debug/icnss/stats
        log -t WifiL13A disable_antenna switch
    else
        echo 1 > /sys/module/icnss/parameters/do_antenna_switch
        cat /sys/kernel/debug/icnss/stats
        log -t WifiL13A enable_antenna switch
    fi
elif [ "$L13Aswitch" == "0" ]; then
    echo 0 > /sys/module/icnss/parameters/do_antenna_switch
    cat /sys/kernel/debug/icnss/stats
    log -t WifiL13A disable_antenna switch
else
    echo 1 > /sys/module/icnss/parameters/do_antenna_switch
    cat /sys/kernel/debug/icnss/stats
    log -t WifiL13A enable_antenna switch
fi

