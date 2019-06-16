#!/system/bin/sh
kernelmessage_flag=`getprop persist.asus.kernelmessage`
is_oemuartlog_exist=`cat /proc/cmdline | grep UARTLOG`
if test "$is_oemuartlog_exist"; then
	echo 7 > /proc/sys/kernel/printk
#	setprop persist.asus.asusklog 1
	setprop sys.config.klog 1
else
	echo "$kernelmessage_flag" > /proc/sys/kernel/printk
	if [ ".$kernelmessage_flag" == ".0" ];then
#		setprop persist.asus.asusklog 0
		setprop sys.config.klog 0
	elif [ ".$kernelmessage_flag" == ".7" ];then
#		setprop persist.asus.asusklog 1
		setprop sys.config.klog 1
	else
		echo "not set prop of kernelmessage"
	fi
fi
