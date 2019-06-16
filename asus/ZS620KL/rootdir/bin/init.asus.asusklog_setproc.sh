#!/system/bin/sh
asusklog_mode=`getprop sys.config.klog`
if [ ".$asusklog_mode" == ".0" ];then
		echo 0 > /proc/asusklog
elif [ ".$asusklog_mode" == ".1" ];then
		echo 1 > /proc/asusklog
else
	echo "error sys.config.klog"
fi
