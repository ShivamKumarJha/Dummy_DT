#!/system/bin/sh
echo 1 > /sys/fs/selinux/log
startlog_flag=`getprop persist.asus.startlog`
DownloadMode_flag=`getprop persist.sys.downloadmode.enable`
echo "ASDF: Check LastShutdown log." > /proc/asusevtlog
echo get_asdf_log > /proc/asusdebug

dd if=/dev/block/bootdevice/by-name/ftm of=/data/vendor/ramdump/miniramdump_header.txt bs=4 count=2

var=$(cat /data/vendor/ramdump/miniramdump_header.txt)
if test "$var" = "Raw_Dmp!"
then
	#echo Found Raw Ram Dump!
	#echo Start to dump...
	fext="$(date +%Y%m%d-%H%M%S).txt"
	dd if=/dev/block/bootdevice/by-name/ftm of=/vendor/asdf/LastShutdownCrash_$fext skip=34509396 ibs=1 count=262144 
	dd if=/dev/block/bootdevice/by-name/ftm of=/vendor/asdf/LastShutdownLogcat_$fext skip=34771540 ibs=1 count=1048576 
	dd if=/dev/block/bootdevice/by-name/ftm of=/vendor/asdf/LastTZLogCrash_$fext skip=47715988 ibs=1 count=13312 
	
	echo "MiniDump" > /data/vendor/ramdump/miniramdump_header.txt
	dd if=/data/vendor/ramdump/miniramdump_header.txt of=/dev/block/bootdevice/by-name/ftm bs=4 count=2
	rm /data/vendor/ramdump/miniramdump_header.txt
	#am broadcast -a android.intent.action.MEDIA_MOUNTED --ez read-only false -d file:///storage/emulated/0/ -p com.android.providers.media 
	#echo Finish!
#else
	#echo Not Found Raw Ram Dump.
fi

if test "$DownloadMode_flag" -eq 1; then
		echo 1 > /sys/module/msm_poweroff/parameters/download_mode
		#echo 1 > /sys/module/printk/parameters/ramdump_enabled
		echo full > /sys/kernel/dload/dload_mode
else

#	if test "$startlog_flag" -eq 1; then
		echo 1 > /sys/module/msm_poweroff/parameters/download_mode
		#echo 1 > /sys/module/printk/parameters/ramdump_enabled
		echo mini > /sys/kernel/dload/dload_mode
#	else
#		echo 0 > /sys/module/msm_poweroff/parameters/download_mode
		#echo 0 > /sys/module/printk/parameters/ramdump_enabled
#		echo mini > /sys/kernel/dload/dload_mode
#	fi
fi


echo 0 > /sys/fs/selinux/log
