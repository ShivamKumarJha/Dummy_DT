#!/vendor/bin/sh

product_prop=`getprop ro.target_product`
board_prop=`getprop ro.product.board`
device_prop=`getprop ro.product.device`


if [ ".$product_prop" == ".ZB555KL" ] && [ ".$board_prop" == ".MSM8937" ] && [ ".$device_prop" == ".ASUS_X00P_4" ]; then
    echo "do nothing"
elif [ ".$product_prop" == ".ZB555KL" ] && [ ".$board_prop" == ".MSM8937" ] && [ ".$device_prop" == ".ASUS_X00P_6" ]; then
    echo "do nothing"
elif [ ".$product_prop" == ".ZB555KL" ] && [ ".$board_prop" == ".MSM8917" ] && [ ".$device_prop" == ".ASUS_X00P_8" ]; then
    echo "do nothing"
else
    #support gyroscope sensor
    ln -s /vendor/etc/permissions/wait/android.hardware.sensor.gyroscope.xml /factory/android.hardware.sensor.gyroscope.xml
fi
