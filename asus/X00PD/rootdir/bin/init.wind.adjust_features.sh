#!/vendor/bin/sh

product_prop=`getprop ro.target_product`
platform_prop=`getprop ro.boot.platformtype`
boardid_prop=`getprop ro.boot.board_id`

if [ ".$product_prop" == ".ZA555KL" ] && [ ".$boardid_prop" == ".4" ]; then
    echo "do nothing"
elif [ ".$product_prop" == ".ZB555KL" ] && [ ".$boardid_prop" == ".7" ]; then
    echo "do nothing"
else
    #support gyroscope sensor
    ln -s /vendor/etc/permissions/wait/android.hardware.sensor.gyroscope.xml /factory/android.hardware.sensor.gyroscope.xml
fi