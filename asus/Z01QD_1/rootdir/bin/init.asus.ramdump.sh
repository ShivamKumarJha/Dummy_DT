#!/system/bin/sh
ramdump_flag=`getprop persist.asus.ramdump`
echo "$ramdump_flag" > /sys/kernel/debug/Asus_ramdump/Asus_ramdump_flag

sleep 40
is_autosavelog_exist=`busybox cat /proc/cmdline | busybox grep autosavelog`
if busybox test "$is_autosavelog_exist"; then
	autosavelogmtp_flag=`getprop persist.asus.autosavelogmtp`
	if busybox test $autosavelogmtp_flag -eq 1 ; then
		start savelogmtp
		exit
	fi
fi	

