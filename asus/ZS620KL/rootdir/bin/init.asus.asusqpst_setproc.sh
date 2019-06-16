#!/system/bin/sh
asqpst_mode=`getprop debug.asus.trigger.qpstmode`
if [ ".$asqpst_mode" == ".1" ];then
		echo panic > /proc/asusdebug
		setprop debug.asus.trigger.qpstmode 0
elif [ ".$asqpst_mode" == ".0" ];then
		setprop debug.asus.trigger.qpstmode 2
else
	echo "error debug.asus.trigger.qpstmode"
fi
