#!/system/vendor/bin/sh

echo "Start clear csc log"
LOG_LOGCAT_FOLDER='/data/logcat_log'
LOG_MODEM_FOLDER='/sdcard/diag_logs'

startLogProp=`getprop persist.vendor.asus.startlog`

if [ "${startLogProp}" = "1" ]; then
	setprop persist.vendor.asus.startlog 0
	sleep 3
fi
rm -rf $LOG_LOGCAT_FOLDER/*
if [ "${startLogProp}" = "1" ]; then
	setprop persist.vendor.asus.startlog 1
	sleep 3
fi

if [ -d "/data/media/0/diag_logs/" ]; then
	#add to stop and then capture modem log problem
	enableQXDM=`getprop persist.asus.qxdmlog.enable`
	if [ "${enableQXDM}" = "1" ]; then
		wait_cmd=`setprop persist.asus.qxdmlog.enable 0`
		echo "Turn off QXDM log for clear log"
		sleep 3
		sync
		QXDM_turn_off=1
	fi
		
	#rm QXDM log
	wait_cmd=`rm -rf /data/media/0/diag_logs`
	sync

	#add to stop and then capture modem log problem
	if [ "${QXDM_turn_off}" = "1" ]; then
		wait_cmd=`setprop persist.asus.qxdmlog.enable 1`
		echo "Turn on QXDM log for clear log"
		QXDM_turn_off=0
	fi
fi
# Delete logcat log & tcp dump

setprop debug.asus.clearlog 0


