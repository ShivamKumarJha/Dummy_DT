#!/system/bin/sh
cmdline_uart=`cat /proc/cmdline | grep dbg=y`
cmdline_klog=`cat /proc/cmdline | grep klog=y`
is_factory_build=`getprop ro.asus.factory`
is_user_build=`getprop ro.build.type`
is_audbg=`getprop persist.asus.audbg`
startlog_flag=`getprop persist.asus.startlog`

if test "$cmdline_uart"; then
	if [ ".$is_user_build" == ".userdebug"  -o ".$is_user_build" == ".eng"  ];then
		if [ ".$is_audbg" == ".1" ]; then
			echo dbg > /proc/asusdebug
		else
			echo ndbg > /proc/asusdebug
		fi
		if test "$cmdline_klog"; then
			setprop persist.asus.kernelmessage 7
		else
			setprop persist.asus.kernelmessage 0
		fi
	fi
else
	setprop persist.asus.audbg 0
	echo ndbg > /proc/asusdebug
	if test "$cmdline_klog"; then
		if [ ".$startlog_flag" == ".1" ];then
			setprop persist.asus.kernelmessage 7
		else
			setprop persist.asus.kernelmessage 0
		fi
	fi
fi
