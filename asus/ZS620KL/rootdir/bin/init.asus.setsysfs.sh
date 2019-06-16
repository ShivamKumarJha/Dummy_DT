#!/system/bin/sh
asdownload_mode=`getprop persist.asuslog.qpst.enable`
asrtb_mode=`getprop persist.asuslog.rtb.enable`
asmodemramdump_mode=`getprop persist.asuslog.modem.ramdumps`
astriggermodemreset_mode=`getprop debug.asus.trigger.modemreset`
asqxdmlog_mode=`getprop persist.asuslog.qxdmlog.enable`

if [ ".$asdownload_mode" == ".0" ];then
		echo 0 > /sys/module/msm_poweroff/parameters/download_mode
elif [ ".$asdownload_mode" == ".1" ];then
		echo 1 > /sys/module/msm_poweroff/parameters/download_mode
fi

if [ ".$asrtb_mode" == ".0" ];then
		echo 0 > /sys/module/msm_rtb/parameters/enable
elif [ ".$asrtb_mode" == ".1" ];then
		echo 1 > /sys/module/msm_rtb/parameters/enable
fi

if [ ".$asmodemramdump_mode" == ".0" ];then
		echo 0 > /sys/module/subsystem_restart/parameters/enable_ramdumps
elif [ ".$asmodemramdump_mode" == ".1" ];then
		echo 1 > /sys/module/subsystem_restart/parameters/enable_ramdumps
fi

if [ ".$astriggermodemreset_mode" == ".1" ];then
		echo 1 > /sys/bus/msm_subsys/devices/subsys7/make_crash
fi

if [ ".$asqxdmlog_mode" == ".2" ];then
		echo diag_fwrite > /sys/power/wake_unlock
else
	echo "error persist.asuslog.qxdmlog.enable and etc."
fi
