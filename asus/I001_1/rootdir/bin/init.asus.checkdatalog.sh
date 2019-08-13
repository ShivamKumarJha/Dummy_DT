#!/system/vendor/bin/sh

# Parameter Definition
# $1: Caller

echo 1 > /sys/fs/selinux/log
sleep 3

mkdir /data/logcat_log
restorecon /data/everbootup
is_datalog_exist=`ls /data | grep logcat_log`
startlog_flag=`getprop persist.vendor.asus.startlog`
version_type=`getprop ro.build.type`
check_factory_version=`grep -c androidboot.pre-ftm=1 /proc/cmdline`
is_sb=`grep -c SB=Y /proc/cmdline`
logcat_filenum=`getprop persist.vendor.asus.logcat.filenum`
is_clear_logcat_logs=`getprop sys.asus.logcat.clear`
MAX_ROTATION_NUM=30
Caller=`getprop sys.asus.check-data.caller`

#echo $is_clear_logcat_logs > /proc/asusevtlog
#echo $logcat_filenum > /proc/asusevtlog

if test "$Caller" != ""; then
	setprop sys.asus.check-data.caller ""
fi

 
is_unlocked=`grep -c UNLOCKED=Y /proc/cmdline`


if test "$is_unlocked" = "1"; then
	start logcat-asdf
fi


for logcat in /data/logcat_log/logcat*
do
	size=`stat -c%s $logcat`
	if [ $size -gt 20971520 ]; then
		truncate -s 10485760 $logcat
	fi
done

for asusevtlog in /asdf/ASUSEvtlog*
do
	size=`stat -c%s $asusevtlog`
	if [ $size -gt 20971520  ]; then
		truncate -s 10485760 $asusevtlog
	fi
done



######################################################################################
# For AsusLogTool logcat log rotation number setting
######################################################################################
if [ "$is_clear_logcat_logs" == "1" ]; then
	if [ "$logcat_filenum" != "3" ] && [ "$logcat_filenum" != "10" ] && [ "$logcat_filenum" != "20" ] && [ "$logcat_filenum" != "30" ]; then
		#if logcat_filenum get failed, sleep 1s and retry
		sleep 1
		logcat_filenum=`getprop persist.asus.logcat.filenum`

		if [ "$logcat_filenum" == "" ]; then
			logcat_filenum=20
		fi
	fi

	file_counter=$MAX_ROTATION_NUM
	while [ $file_counter -gt $logcat_filenum ]; do
		if [ $file_counter -lt 10 ]; then
			two_digit_file_counter=0$file_counter;
			
			if [ -e /data/logcat_log/logcat.txt.$two_digit_file_counter ]; then
				rm -f /data/logcat_log/logcat.txt.$two_digit_file_counter
			fi
		fi

		if [ -e /data/logcat_log/logcat.txt.$file_counter ]; then
			rm -f /data/logcat_log/logcat.txt.$file_counter
		fi
		
		file_counter=$(($file_counter-1))
	done

	setprop sys.asus.logcat.clear "0"
fi

######################################################################################
# For original logcat service startlog
######################################################################################
if test -e /data/everbootup; then
	echo 1 > /data/everbootup
	restorecon /data/everbootup
#	echo $is_datalog_exist > /data/everbootup
	startlog_flag=`getprop persist.vendor.asus.startlog`


#	if test "$is_datalog_exist"; then
		chown system.system /data/logcat_log
		chmod 0777 /data/logcat_log
		if test "$Caller" = "OOB"; then
			start logcat-oob
			start logcat-radio-oob
			start logcat-event-oob
		else
			if test "$startlog_flag" -eq 1;then
				start logcat
				start logcat-radio
				start logcat-events
				start logcat-asdf
			else
				stop logcat
				stop logcat-radio
				stop logcat-events
				stop logcat-asdf
			fi
		fi
#	fi        	
else
	setprop persist.asus.ramdump 1
	setprop persist.asus.autosavelogmtp 0
	if  test "$version_type" = "eng"; then
		setprop persist.vendor.asus.startlog 1
		setprop persist.asus.kernelmessage 7
	elif test "$version_type" = "userdebug"; then
			if test "$check_factory_version" = "1"; then
				if test "$is_sb" = "1"; then
					setprop persist.vendor.asus.kernelmessage 0
				else
					setprop persist.vendor.asus.kernelmessage 7
				fi
				setprop persist.vendor.asus.enable_navbar 1
			else
				setprop persist.vendor.asus.kernelmessage 0	
			fi
		setprop persist.vendor.asus.startlog 1
		setprop persist.vendor.sys.downloadmode.enable 1
		
	fi
	
	recheck_datalog=`ls /data | grep logcat_log`

	if test "$recheck_datalog"; then
		chown system.system /data/logcat_log
		chmod 0775 /data/logcat_log
		if test "$Caller" = "OOB"; then
			start logcat-oob
			start logcat-radio-oob
			start logcat-event-oob
		else
			if test "$version_type" = "user";then
				if test "$startlog_flag" -eq 1;then
					start logcat
					start logcat-radio
					start logcat-events
				else
					stop logcat
					stop logcat-radio
					stop logcat-events
					stop logcat-asdf
				fi
			
			else
				start logcat
				start logcat-radio
				start logcat-events
				start logcat-asdf
			fi
		fi
	fi
	echo "[Debug] The file everbootup doesn't exist, data partition might be erased(factory reset)" > /proc/asusevtlog
	echo 0 > /data/everbootup
fi

boot_complete=`getprop sys.boot_completed`
if test "$boot_complete" = "1"; then
	stop logcat-asdf
fi

# bootcount
if test -e "/data/bootcount"; then
	var=$( cat /data/bootcount )
	var=$(($var+1))
	echo ${var}>/data/bootcount
else
	echo 1 >/data/bootcount
fi
#echo 1 > /sys/fs/selinux/log

if test "$startlog_flag" -eq 0; then
sleep 5
echo 0 > /sys/fs/selinux/log
else
echo 1 > /sys/fs/selinux/log
fi



