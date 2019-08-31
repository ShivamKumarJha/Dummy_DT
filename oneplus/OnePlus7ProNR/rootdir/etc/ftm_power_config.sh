#!/system/bin/sh
    echo "ftm_power_config start" > /dev/kmsg
    bootmode=`getprop ro.vendor.factory.mode`
    /vendor/bin/sh /vendor/bin/init.qcom.post_boot.sh
    sleep 5
    echo 0 > /sys/devices/system/cpu/cpu4/online
    echo 0 > /sys/devices/system/cpu/cpu5/online
    echo 0 > /sys/devices/system/cpu/cpu6/online
    echo 0 > /sys/devices/system/cpu/cpu7/online

    echo 0 > /sys/module/lpm_levels/parameters/sleep_disabled
    echo "ftm_power_config done" > /dev/kmsg
    case "$bootmode" in
        "ftm")
        echo "stop qcrild for at test" > /dev/kmsg
        stop vendor.qcrild
        val=2
        while [ $val -gt 0 ]
        do
            cat /sys/power/wake_lock | {
            while read line
            do
                if [[ "$line" == *cril_pre_client_init* || "$line" == *adio-interface* ]]
                then
                    echo again > /sys/power/wake_lock
                    start vendor.qcrild
                    sleep 2
                    stop start vendor.qcrild
                    echo again > /sys/power/wake_unlock
                    echo "stop qcrild again for at test" > /dev/kmsg
                else
                    val=1
                    break
                fi
            done
            }
            sleep 2
            val=`expr $val - 1`
        done
        ;;
    esac
