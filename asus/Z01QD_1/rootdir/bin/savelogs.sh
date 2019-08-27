#!/system/bin/sh

#MODEM_LOG
MODEM_LOG=/data/media/0/ASUS/LogUploader/modem
#MODEM_LOG=/sdcard/ASUS/LogUploader/modem
#TCP_DUMP_LOG
TCP_DUMP_LOG=/data/media/0/ASUS/LogUploader/TCPdump
#TCP_DUMP_LOG=/sdcard/ASUS/LogUploader/TCPdump
#GENERAL_LOG
GENERAL_LOG=/data/media/0/ASUS/LogUploader/general/sdcard
#GENERAL_LOG=/sdcard/ASUS/LogUploader/general/sdcard

#Dumpsys folder
DUMPSYS_DIR=/data/media/0/ASUS/LogUploader/dumpsys
BUGREPORT_PATH=/data/user_de/0/com.android.shell/files/bugreports

#BUSYBOX=busybox
BUGREPORT_PATH=/data/user_de/0/com.android.shell/files/bugreports
GENERAL_LOG=/data/media/0/ASUS/LogUploader/general/sdcard
PATH=/system/bin/:$PATH

echo 1 > /sys/fs/selinux/log

savelogs_prop=`getprop persist.asus.savelogs`
is_tcpdump_status=`getprop init.svc.tcpdump-warp`

save_general_log() {
	############################################################################################
	# save cmdline
	cat /proc/cmdline > $GENERAL_LOG/cmdline.txt
	echo "cat /proc/cmdline > $GENERAL_LOG/cmdline.txt"	
	############################################################################################
	cat /d/wakeup_sources  > $GENERAL_LOG/wakeup_sources.txt
	############################################################################################
	# save mount table
	cat /proc/mounts > $GENERAL_LOG/mounts.txt
	echo "cat /proc/mounts > $GENERAL_LOG/mounts.txt"
	############################################################################################
	getenforce > $GENERAL_LOG/getenforce.txt
	echo "getenforce > $GENERAL_LOG/getenforce.txt"
	############################################################################################
	# save property
	getprop > $GENERAL_LOG/getprop.txt
	echo "getprop > $GENERAL_LOG/getprop.txt"
	############################################################################################
	# save network info
	cat /proc/net/route > $GENERAL_LOG/route.txt
	echo "cat /proc/net/route > $GENERAL_LOG/route.txt"
	netcfg > $GENERAL_LOG/ifconfig.txt
	echo "ifconfig -a > $GENERAL_LOG/ifconfig.txt"
	netstat -anlp > $GENERAL_LOG/netstat.txt
	echo "netstat -anlp > $GENERAL_LOG/netstat.txt"
	############################################################################################
	# save software version
	echo "AP_VER: `getprop ro.build.display.id`" > $GENERAL_LOG/version.txt
	echo "CP_VER: `getprop gsm.version.baseband`" >> $GENERAL_LOG/version.txt
	echo "BT_VER: `getprop bt.version.driver`" >> $GENERAL_LOG/version.txt
	echo "WIFI_VER: `getprop wifi.version.driver`" >> $GENERAL_LOG/version.txt
	echo "WIFI_VER: `getprop wigig.version.driver`" >> $GENERAL_LOG/version.txt
	echo "WIFI_VER: `getprop wigig.dock.version.driver`" >> $GENERAL_LOG/version.txt
	echo "GPS_VER: `getprop gps.version.driver`" >> $GENERAL_LOG/version.txt
	echo "BUILD_DATE: `getprop ro.build.date`" >> $GENERAL_LOG/version.txt
	############################################################################################
	# save load kernel modules
	lsmod > $GENERAL_LOG/lsmod.txt
	echo "lsmod > $GENERAL_LOG/lsmod.txt"
	############################################################################################
	# save process now
	ps -A >  $GENERAL_LOG/ps.txt
	echo "ps > $GENERAL_LOG/ps.txt"
	ps -t -p > $GENERAL_LOG/ps_thread.txt
	echo "ps > $GENERAL_LOG/ps_thread.txt"
	############################################################################################
	# save kernel message
	dmesg > $GENERAL_LOG/dmesg.txt
	echo "dmesg > $GENERAL_LOG/dmesg.txt"
	############################################################################################
	# copy data/log to data/media
	#$BUSYBOX ls -R -l /data/log/ > $GENERAL_LOG/ls_data_log.txt
	#mkdir $GENERAL_LOG/log
	#$BUSYBOX cp /data/log/* $GENERAL_LOG/log/
	#echo "$BUSYBOX cp /data/log $GENERAL_LOG"
	############################################################################################
	# copy data/tombstones to data/media
	ls -R -l /data/tombstones/ > $GENERAL_LOG/ls_data_tombstones.txt
	mkdir $GENERAL_LOG/tombstones
	cp /data/tombstones/* $GENERAL_LOG/tombstones/
	echo "cp /data/tombstones $GENERAL_LOG"	
	############################################################################################

	############################################################################################
	ls -R -l /vendor/asdf > $GENERAL_LOG/ls_asdf.txt
	############################################################################################

	# copy Debug Ion information to data/media
	mkdir $GENERAL_LOG/ION_Debug
	cp -r /d/ion/* $GENERAL_LOG/ION_Debug/
	############################################################################################
	# copy data/logcat_log to data/media
	#busybox ls -R -l /data/logcat_log/ > $GENERAL_LOG/ls_data_logcat_log.txt
	#$BUSYBOX cp -r /data/logcat_log/ $GENERAL_LOG
	#echo "$BUSYBOX cp -r /data/logcat_log $GENERAL_LOG"
	mkdir $GENERAL_LOG/logcat_log
	# logcat & radio
	if [ -d "/data/logcat_log" ]; then
		for x in logcat logcat-radio logcat-events
		do
			cp /data/logcat_log/$x.txt /data/logcat_log/$x.txt.0
			mv /data/logcat_log/$x.txt.* $GENERAL_LOG/logcat_log
		done
	fi
	############################################################################################
	# copy /asdf/ASUSEvtlog.txt to ASDF
	cp -r /sdcard/asus_log/ASUSEvtlog.txt $GENERAL_LOG #backward compatible
	cp -r /sdcard/asus_log/ASUSEvtlog_old.txt $GENERAL_LOG #backward compatible
	cp -r /vendor/asdf/ASUSEvtlog.txt $GENERAL_LOG
	cp -r /vendor/asdf/ASUSEvtlog_old.txt $GENERAL_LOG
	cp -r /vendor/asdf/ASDF $GENERAL_LOG
	cp -r /vendor/asdf/dumpsys_meminfo $GENERAL_LOG && rm -r /vendor/asdf/dumpsys_meminfo
	cp -r /vendor/asdf/ $GENERAL_LOG/asdf2
	echo "cp -r /asdf/ASUSEvtlog.txt $GENERAL_LOG"

	for fname in /vendor/asdf/ASUSSlowg*
	do
		if [ -e $fname ]; then
			echo "$fname found!" >/dev/kmsg 
			rm $fname
		fi
	done

	############################################################################################
	# save charger information
	mkdir $GENERAL_LOG/charger_debug/
	echo 3600 > /d/regmap/spmi0-02/count
	echo 0x1000 > /d/regmap/spmi0-02/address
	cat /d/regmap/spmi0-02/data > $GENERAL_LOG/charger_debug/pmic_reg.txt
	cat /d/pmic-votable/*/status > $GENERAL_LOG/charger_debug/pmic_voter.txt
	cat /sys/class/power_supply/*/uevent > $GENERAL_LOG/charger_debug/uevent.txt
	############################################################################################
	# copy /sdcard/wlan_logs/
	cp -r /sdcard/wlan_logs/cnss_fw_logs_current.txt $GENERAL_LOG
	echo "cp -r /sdcard/wlan_logs/cnss_fw_logs_current.txt $GENERAL_LOG"
	############################################################################################
	cp -r /data/misc/wifi/WifiConfigStore.xml $GENERAL_LOG
	echo "cp -r /data/misc/wifi/WifiConfigStore.xml $GENERAL_LOG"
	# copy /data/misc/wifi/wpa_supplicant.conf
	# copy /data/misc/wifi/hostapd.conf
	# copy /data/misc/wifi/p2p_supplicant.conf
	ls -R -l /data/misc/wifi/ > $GENERAL_LOG/ls_wifi_asus_log.txt
	cp -r /data/misc/wifi/wpa_supplicant.conf $GENERAL_LOG
	echo "cp -r /data/misc/wifi/wpa_supplicant.conf $GENERAL_LOG"
	cp -r /data/misc/wifi/hostapd.conf $GENERAL_LOG
	echo "cp -r /data/misc/wifi/hostapd.conf $GENERAL_LOG"
	cp -r /data/misc/wifi/p2p_supplicant.conf $GENERAL_LOG
	echo "cp -r /data/misc/wifi/p2p_supplicant.conf $GENERAL_LOG"
	############################################################################################
	# mv /data/anr to data/media
	ls -R -l /data/anr > $GENERAL_LOG/ls_data_anr.txt
	mkdir $GENERAL_LOG/anr
	cp /data/anr/* $GENERAL_LOG/anr/
	echo "cp /data/anr $GENERAL_LOG"
	############################################################################################
	# save system information
	mkdir $DUMPSYS_DIR
    for x in SurfaceFlinger window activity input_method alarm power battery meminfo batterystats sensorservice; do
        dumpsys -t 30 $x > $DUMPSYS_DIR/$x.txt
        echo "dumpsys $x > $DUMPSYS_DIR/$x.txt"
    done

        dumpsys -t 50 > $GENERAL_LOG/dumpsys.txt
	
    ############################################################################################
    # [BugReporter]Save ps.txt to Dumpsys folder
    ps -A  > $DUMPSYS_DIR/ps.txt
    ############################################################################################
    date > $GENERAL_LOG/date.txt
	echo "date > $GENERAL_LOG/date.txt"
	############################################################################################	
	# save debug report
    #dumpstate -q > $GENERAL_LOG/dumpstate.txt
    #echo "dumpstate > $DUMPSYS_DIR/dumpstate.txt"
#	dumpstate -q -d -z -o $BUGREPORT_PATH/bugreport
#	for filename in $BUGREPORT_PATH/*; do
#	    name=${filename##*/}
#	    cp $filename  $GENERAL_LOG/$name
#	    rm $filename
#	done

	############################################################################################
    micropTest=`cat /sys/class/switch/pfs_pad_ec/state`
	if [ "${micropTest}" = "1" ]; then
	    date > $GENERAL_LOG/microp_dump.txt
	    cat /d/gpio >> $GENERAL_LOG/microp_dump.txt                   
        echo "cat /d/gpio > $GENERAL_LOG/microp_dump.txt"  
        cat /d/microp >> $GENERAL_LOG/microp_dump.txt
        echo "cat /d/microp > $GENERAL_LOG/microp_dump.txt"
	fi
	############################################################################################
	df > $GENERAL_LOG/df.txt
	echo "df > $GENERAL_LOG/df.txt"
	###########################################################################################
	lsof > $GENERAL_LOG/lsof.txt
	mkdir  $GENERAL_LOG/ap_ramdump
	cp -r  /data/media/ap_ramdump/* $GENERAL_LOG/ap_ramdump/
	mkdir  $GENERAL_LOG/recovery
	cp -r  /cache/recovery/* $GENERAL_LOG/recovery
	vmstat 1 5 > $GENERAL_LOG/vmstat.txt
        mkdir $GENERAL_LOG/Power_Err_log
        cp /vendor/asdf/ASUS_*.txt $GENERAL_LOG/Power_Err_log

	#############################################################################################
	dd if=/dev/block/bootdevice/by-name/ftm of=/data/vendor/ramdump/miniramdump_header.txt bs=4 count=2

	var=$(cat /data/vendor/ramdump/miniramdump_header.txt)
	if test "$var" = "MiniDump"
	then
       		#echo Found Raw Ram Dump!
        	#echo Start to dump...
        	echo "Raw_Dmp!" > /data/vendor/ramdump/miniramdump_header.txt
        	dd if=/data/vendor/ramdump/miniramdump_header.txt of=/dev/block/bootdevice/by-name/ftm bs=4 count=2
        	dd if=/dev/block/bootdevice/by-name/ftm of=/data/vendor/ramdump/MiniRawRamDump.bin

        	tar -czvf $GENERAL_LOG/MiniRawRamDump.tgz /data/vendor/ramdump/MiniRawRamDump.bin

        	rm /data/vendor/ramdump/MiniRawRamDump.bin
        	rm /data/vendor/ramdump/miniramdump_header.txt
        	dd if=/dev/zero of=/dev/block/bootdevice/by-name/ftm bs=4 count=2

        #am broadcast -a android.intent.action.MEDIA_MOUNTED --ez read-only false -d file:///storage/emulated/0/ -p com.android.providers.media
        #echo Finish!
#else
        #echo Not Found Raw Ram Dump.
	fi
	#############################################################################################


        #mv /data/media/0/ssr_ramdump/ $SAVE_LOG_PATH
        cp -r  /data/media/0/ssr_ramdump/ $GENERAL_LOG
        #rm -r  /data/media/0/ssr_ramdump/
        echo "mv /data/media/0/ssr_ramdump $GENERAL_LOG"



        bugreportz > $GENERAL_LOG/bugreportz_log.txt
        for filename in $BUGREPORT_PATH/*; do
            name=${filename##*/}
           cp $filename  $GENERAL_LOG/$name
            rm $filename
        done
	rm -r /data/misc/bluetooth/logs/*.*
	rm -r /data/vendor/ramdump/bluetooth/*.*

 


	############################################################################################
#	dumpstate -q -d -z -o $GENERAL_LOG/bugreport

chmod -R 777 $GENERAL_LOG

am broadcast -a com.asus.savelogs.completed
setprop persist.asus.savelogs.complete 0
setprop persist.asus.savelogs.complete 1




}

save_modem_log() {
	mv /data/media/diag_logs/QXDM_logs $MODEM_LOG 
	echo "mv /data/media/diag_logs/QXDM_logs $MODEM_LOG"
}

save_tcpdump_log() {
	if [ -d "/data/logcat_log" ]; then
		if [ ".$is_tcpdump_status" == ".running" ]; then
			stop tcpdump-warp
			mv /data/logcat_log/capture.pcap0 /data/logcat_log/capture.pcap0-1
			start tcpdump-warp
			for fname in /data/logcat_log/capture.pcap*
			do
				if [ -e $fname ]; then
					if [ ".$fname" != "./data/logcat_log/capture.pcap0" ]; then
						mv $fname $TCP_DUMP_LOG
					fi
				fi
			done
		else
			mv /data/logcat_log/capture.pcap* $TCP_DUMP_LOG
		fi
	fi
}

remove_folder() {
	# remove folder
	if [ -e $GENERAL_LOG ]; then
		rm -r $GENERAL_LOG
	fi
	
	if [ -e $MODEM_LOG ]; then
		rm -r $MODEM_LOG
	fi
	
	if [ -e $TCP_DUMP_LOG ]; then
		rm -r $TCP_DUMP_LOG
	fi

	if [ -e $DUMPSYS_DIR ]; then
		rm -r $DUMPSYS_DIR
	fi
}

create_folder() {
	# create folder
	mkdir -p $GENERAL_LOG
	echo "mkdir -p $GENERAL_LOG"
	
	mkdir -p $MODEM_LOG
	echo "mkdir -p $MODEM_LOG"
	
	mkdir -p $TCP_DUMP_LOG
	echo "mkdir -p $GENERAL_LOG"
}

if [ ".$savelogs_prop" == ".0" ]; then
	remove_folder
    setprop persist.asus.uts com.asus.removelogs.completed
    setprop persist.asus.savelogs.complete 0
    setprop persist.asus.savelogs.complete 1
#	am broadcast -a "com.asus.removelogs.completed"
elif [ ".$savelogs_prop" == ".1" ]; then
	# check mount file
	umask 0;
	sync
	############################################################################################
	# remove folder
	remove_folder

	# create folder
	create_folder
	
	# save_general_log
	save_general_log
	
	############################################################################################
	# sync data to disk 
	# 1015 sdcard_rw
	chmod -R 777 $GENERAL_LOG
	sync

#    setprop persist.asus.uts com.asus.savelogs.completed
#    setprop persist.asus.savelogs.complete 0
#    setprop persist.asus.savelogs.complete 1
	#am broadcast -a "com.asus.savelogs.completed"
 
	echo "Done"
elif [ ".$savelogs_prop" == ".2" ]; then
	# check mount file
	umask 0;
	sync
	############################################################################################
	# remove folder
	remove_folder

	# create folder
	create_folder
	
	# save_modem_log
	save_modem_log
	
	############################################################################################
	# sync data to disk 
	# 1015 sdcard_rw
	chmod -R 777 $MODEM_LOG
	sync

    setprop persist.asus.uts com.asus.savelogs.completed
    setprop persist.asus.savelogs.complete 0
    setprop persist.asus.savelogs.complete 1
	#am broadcast -a "com.asus.savelogs.completed"
 
	echo "Done"
elif [ ".$savelogs_prop" == ".3" ]; then
	# check mount file
	umask 0;
	sync
	############################################################################################
	# remove folder
	remove_folder

	# create folder
	create_folder
	
	# save_tcpdump_log
	save_tcpdump_log
	
	############################################################################################
	# sync data to disk 
	# 1015 sdcard_rw
	chmod -R 777 $TCP_DUMP_LOG
	sync

    setprop persist.asus.uts com.asus.savelogs.completed
    setprop persist.asus.savelogs.complete 0
    setprop persist.asus.savelogs.complete 1
#	am broadcast -a "com.asus.savelogs.completed"
 
	echo "Done"
elif [ ".$savelogs_prop" == ".4" ]; then
	# check mount file
	umask 0;
	sync
	############################################################################################
	# remove folder
	remove_folder

	# create folder
	create_folder
	
	# save_general_log
	save_general_log
	
	# save_modem_log
	save_modem_log
	
	# save_tcpdump_log
	save_tcpdump_log
	
	############################################################################################
	# sync data to disk 
	# 1015 sdcard_rw
	chmod -R 777 $GENERAL_LOG
	chmod -R 777 $MODEM_LOG
	chmod -R 777 $TCP_DUMP_LOG
#    setprop persist.asus.uts com.asus.savelogs.completed
#    setprop persist.asus.savelogs.complete 0
#    setprop persist.asus.savelogs.complete 1
#    am broadcast -a "com.asus.savelogs.completed"
fi
echo 0 > /sys/fs/selinux/log
