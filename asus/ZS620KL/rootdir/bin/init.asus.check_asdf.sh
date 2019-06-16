#!/system/bin/sh
#This version for A80 only
#[Setup log & env]
log_head='ASDF'
action_log='/dev/console'		#set /dev/null to turn off log
log_root='/vendor/asdf/ASDF'	#Abnormal Shutdown Data Files
trigger_log="$log_root/Total_Recall.txt"
trigger_old="$log_root.old/Total_Recall.txt"
log_dir="$log_root/ASDF"
log_old="$log_root.old/ASDF"
max_log=20

android_boot=`getprop sys.boot_completed`

android_reboot_prop='debug.asus.android_reboot'
android_reboot=`getprop $android_reboot_prop`

act_prop='persist.radio.check_asdf'
act_code=`getprop $act_prop`
chk_result="/dev/asdf_result.html"
#	[1	]	[2 abc	]	[3 def	]
#	[4 ghi	]	[5 jkl	]	[6 mno	]
#	[7 pqrs	]	[8 tuv	]	[9 wxyz	]
#	[* +	]	[0 ﹇	]	[# ⇧	]
# asdf => 2733

if [ ".$android_reboot" == "." ]; then
	if [ -e $log_root ]; then
		echo "$log_head: found log_root=$log_root" > $action_log
	else
		echo "$log_head: creating log_root=$log_root" > $action_log
		mkdir $log_root
	fi
fi

if [ ".$act_code" == ".2733" ]; then
	setprop $act_prop ''	#reset property

	echo "$log_head: print ASDF result...." > $action_log
	echo "<html><body><pre>" > $chk_result
	if [ -e $trigger_log ]; then
		cat $trigger_log >> $chk_result
	else
		echo "no result!!" >> $chk_result
	fi
	echo "</pre></body></html>" >> $chk_result
	chmod 644 $chk_result
	input keyevent 82
	am force-stop com.android.htmlviewer
	am start -n com.android.htmlviewer/com.android.htmlviewer.HTMLViewerActivity -d file://$chk_result
elif [ ".$act_code" == ".8564" ]; then #8564 for "ulog"
		# check mount file
		sync
		# create savelog folder (UTC)
		SAVE_LOG_ROOT=/data/media/0/save_log 
		SAVE_LOG_PATH="$SAVE_LOG_ROOT/`date +%Y_%m_%d_%H_%M_%S`"
		mkdir -p $SAVE_LOG_PATH
		echo "[$(date +%F_%T)] start to capture logs" > $SAVE_LOG_PATH/ulog_transfer.log
		setprop asus.savelogmtp.folder $SAVE_LOG_PATH
			echo "[$(date +%F_%T)] save system information" >> $SAVE_LOG_PATH/ulog_transfer.log
			# save property
			getprop > $SAVE_LOG_PATH/getprop.txt
			# save proc
			cat /proc/cmdline > $SAVE_LOG_PATH/cmdline.txt
			cat /proc/mounts > $SAVE_LOG_PATH/mounts.txt
			# save software version
			echo "AP_VER: `getprop ro.build.display.id`" > $SAVE_LOG_PATH/version.txt
			echo "CP_VER: `getprop gsm.version.baseband`" >> $SAVE_LOG_PATH/version.txt
			echo "BUILD_DATE: `getprop ro.build.date`" >> $SAVE_LOG_PATH/version.txt
			# save info
			logcat -v time -d > $SAVE_LOG_PATH/logcat.txt
			dumpsys > $SAVE_LOG_PATH/bugreport.txt
			date > $SAVE_LOG_PATH/date.txt
			dmesg > $SAVE_LOG_PATH/dmesg.txt
			netcfg > $SAVE_LOG_PATH/netcfg.txt
			lsmod > $SAVE_LOG_PATH/lsmod.txt
			ps > $SAVE_LOG_PATH/ps.txt
			ps -t > $SAVE_LOG_PATH/ps_thread.txt
			# dump system information
			mkdir -p $SAVE_LOG_PATH/dumpsys
			for dname in alarm bettery batterystats power SurfaceFlinger window activity input_method
			do
				dumpsys $dname > $SAVE_LOG_PATH/dumpsys/$dname.txt
			done
			echo "[$(date +%F_%T)] transfering logs" >> $SAVE_LOG_PATH/ulog_transfer.log
			# copy logs to save_log
			cp -r /vendor/asdf/ $SAVE_LOG_PATH >> $SAVE_LOG_PATH/ulog_transfer.log
			mkdir -p $SAVE_LOG_PATH/data
			for lname in anr log logcat_log tombstones media/ap_ramdump media/diag_logs/QXDM_logs
			do
				cp -r /data/$lname $SAVE_LOG_PATH/data >> $SAVE_LOG_PATH/ulog_transfer.log
			done
			mkdir -p $SAVE_LOG_PATH/wifi
			cp /data/misc/wifi/wpa_supplicant.conf $SAVE_LOG_PATH/wifi >> $SAVE_LOG_PATH/ulog_transfer.log
			cp /data/misc/wifi/hostapd.conf $SAVE_LOG_PATH/wifi >> $SAVE_LOG_PATH/ulog_transfer.log
			cp /data/misc/wifi/p2p_supplicant.conf $SAVE_LOG_PATH/wifi >> $SAVE_LOG_PATH/ulog_transfer.log
			# check microp
			micropTest=`cat /sys/class/switch/pfs_pad_ec/state`
			if [ "${micropTest}" = "1" ]; then
				date > $SAVE_LOG_PATH/microp_dump.txt
				cat /d/gpio >> $SAVE_LOG_PATH/microp_dump.txt
				cat /d/microp >> $SAVE_LOG_PATH/microp_dump.txt
			fi
		# sync data to disk (1015 sdcard_rw)
		chmod -R 777 $SAVE_LOG_ROOT
		sync
		echo "[$(date +%F_%T)] all logs captured successfully" >> $SAVE_LOG_PATH/ulog_transfer.log
		echo "Log path: $SAVE_LOG_PATH" >> $SAVE_LOG_PATH/ulog_transfer.log
		#am broadcast -a android.intent.action.MEDIA_MOUNTED --ez read-only false -d file:///storage/emulated/0/
		echo "<html><body><pre>" > $chk_result
		cat $SAVE_LOG_PATH/ulog_transfer.log >> $chk_result
		echo "</pre></body></html>" >> $chk_result
		chmod 644 $chk_result
		input keyevent 82
		am force-stop com.android.htmlviewer
		am start -n com.android.htmlviewer/com.android.htmlviewer.HTMLViewerActivity -d file://$chk_result
		echo 1000 > /sys/class/timed_output/vibrator/enable
elif [ ".$android_boot" == ".1" ]; then
	if [ ".$android_reboot" == "." ]; then
		setprop $android_reboot_prop 0
		echo "$log_head: 1st boot_completed...." > $action_log
		#Check if there is an abnormal shutdown occured
		fcount=0
		for fname in /vendor/asdf/ASUSSlowg* /vendor/asdf/LastShutdown* /vendor/asdf/rtb*
		do
			if [ -e $fname ]; then
				fcount=$(($fcount+1))
			fi
		done
		echo "==========>ASDF count: $fcount" > $action_log

		if [ $fcount -gt 0 ]; then
			echo "$log_head: <$(date +%F_%T)>Abnormal shutdown logs found!" > $action_log

			#ASDF rotation
			if [ -e $log_dir.1 ]; then
				echo "$log_head: Start rotating log_dir!" > $action_log
				mv $log_root $log_root.old
				mkdir $log_root
				mv $trigger_old $trigger_log
				i=$(($max_log-1))
				while [ $i -gt 0 ]; do
					if [ -e $log_old.$i ]; then
						echo "$log_head: rotate log_dir.$i to log_dir.$(($i+1))" > $action_log
						mv $log_old.$i $log_dir.$(($i+1))
					fi
					i=$(($i-1))
				done
				rm -r $log_root.old

			fi

			#create new ASDF
			echo "$log_head: Creating new log_dir" > $action_log
			mkdir $log_dir.1

			#backup ASDF
			echo "$log_head: Backup log files...." > $action_log

			fcount=0
			fext="$(date +%Y%m%d-%H%M%S).txt"
			cd /vendor/asdf
			for fname in ASUSSlowg* LastShutdown* rtb*
			do
				if [ -e $fname ]; then
					echo "$log_head: $PWD/$fname found!" > $action_log
					cat $fname > $log_dir.1/${fname%${fname:(-4)}}_$fext && rm $fname
					fcount=$(($fcount+1))
				fi
			done

			cd /data/anr
			for fname in traces*
			do
				if [ -e $fname ]; then
					echo "$log_head: $PWD/$fname found!" > $action_log
					cat $fname > $log_dir.1/$fname && rm $fname
					fcount=$(($fcount+1))
				fi
			done

			echo "$log_head: <$(date +%F_%T)>Job done!" > $action_log

			echo "$(date +%F_%T)> backup $fcount log(s)" >> $trigger_log
			echo "ASDF: backup $fcount log(s)" > /proc/asusevtlog
			#am broadcast -a "com.asus.loguploader.action.ASDF_ABNORMAL_REBOOT"
			#am broadcast -a "com.asus.loguploader.action.ASDF_ABNORMAL_REBOOT_ciq"
			
		fi
	else
		android_reboot=$(($android_reboot+1))
		setprop $android_reboot_prop $android_reboot
		echo "$log_head: Android restart....($android_reboot)" > $action_log
		echo "$(date +%F_%T)> Android restart!($android_reboot)" >> $trigger_log
		echo "[Debug] Android restart....($android_reboot)" > /proc/asusevtlog
	fi
fi



