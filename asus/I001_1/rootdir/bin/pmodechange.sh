#!/system/vendor/bin/sh


pmode=`getprop sys.foregroundapp`
setprop vendor.asus.foregroundapp "$pmode"


echo "pmodechange:$pmode" > /dev/kmsg
