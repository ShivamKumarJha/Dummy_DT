#!/system/bin/sh

dongle_type=`getprop sys.asus.dongletype`
echo $dongle_type > sys/devices/platform/goodix_ts.0/dongle_state
