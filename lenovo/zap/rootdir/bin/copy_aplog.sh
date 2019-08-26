#!/vendor/bin/sh

# Add by wangwq14 for Save aplogs

# Let /vendor/bin/sh can use tools in '/system/bin'
export PATH=$PATH:/system/bin

umask 022

Log(){
    log -p d -t copy_aplog $1
}

CollectIpinfo(){
    IP_RULES_LOGFILE=${APLOG_DIR}"/ip_info.txt"

    Log "start to collect ipinfo"
    date > $IP_RULES_LOGFILE

    # iptables -L
    echo "" >> $IP_RULES_LOGFILE
    echo "*-*-*—*-*-*-*—* iptables -L *-*-*—*-*-*-*—*" >> $IP_RULES_LOGFILE
    /system/bin/iptables -L >> $IP_RULES_LOGFILE

    # iptables -S
    echo "" >> $IP_RULES_LOGFILE
    echo "*-*-*—*-*-*-*—* iptables -S *-*-*—*-*-*-*—*" >> $IP_RULES_LOGFILE
    /system/bin/iptables -S >> $IP_RULES_LOGFILE

    #ip rule
    echo "" >> $IP_RULES_LOGFILE
    echo "*-*-*—*-*-*-*—* ip rule *-*-*—*-*-*-*—*" >> $IP_RULES_LOGFILE
    /system/bin/ip rule >> $IP_RULES_LOGFILE

    #ip route
    echo "" >> $IP_RULES_LOGFILE
    echo "*-*-*—*-*-*-*—* ip route *-*-*—*-*-*-*—*" >> $IP_RULES_LOGFILE
    /system/bin/ip route list table 0 >> $IP_RULES_LOGFILE

    Log "end collection info"
}

APLOG_DIR=/data/vendor/newlog/aplog

TMLOG_DIR=/persist/testmode
TMLOG_ALL_DIR=/persist/testmode.*
GPSLOG_DIR=/data/gps/log
ANR_DIR=/data/anr
RECOVERY_DIR=/cache/recovery
CRASH_DIR=/data/tombstones
BT_DIR=/data/misc/bluedroid
BT_ETC_DIR=/system/etc/bluetooth
BT_DATA_DIR=/data/bt-ram-dumps
BT_LOG=/data/misc/bluetooth/logs
WLAN_DIR=/data/misc/wifi
DDR_ID=/sys/devices/system/soc/soc0/ddr_id

Log "Start copy_aplog"

# temp modufy: sync with SecretCode
sleep 3

cd $APLOG_DIR && rm -fr gps anr recovery wlan
cat /proc/interrupts > $APLOG_DIR/interrupts.txt
cat /proc/meminfo > $APLOG_DIR/meminfo.txt
cat /d/ion/heaps/system > $APLOG_DIR/ion_system.txt
getprop > $APLOG_DIR/prop.txt

[ -e /system/build.prop ] && cp /system/build.prop $APLOG_DIR/
[ -e /system/etc/version.conf ] && cp /system/etc/version.conf $APLOG_DIR/
#[ -d $GPSLOG_DIR ] && cp -a $GPSLOG_DIR $APLOG_DIR/gps
#[ -d $ANR_DIR ] &&  cp -a $ANR_DIR $APLOG_DIR/anr
#[ -d $RECOVERY_DIR ] && cp -a $RECOVERY_DIR $APLOG_DIR/recovery
#[ -d $CRASH_DIR ] && cp -a $CRASH_DIR $APLOG_DIR/tombstones

# copy bluetooth data
if [ $(getprop persist.bluetooth.btsnoopenable) = true ]; then
    [ -d $BT_ETC_DIR ] && cp -a $BT_ETC_DIR/* $APLOG_DIR/bluetooth
    [ -d $BT_DIR ] && cp -a $BT_DIR/* $APLOG_DIR/bluetooth
    [ -d $BT_DATA_DIR ] && cp -a $BT_DATA_DIR/hci_snoop* $APLOG_DIR/bluetooth
    [ -d $BT_LOG ] && cp -a $BT_LOG/* $APLOG_DIR/bluetooth
    Log "Copy bluetooth data done"
else
    Log "Copy bluetooth data not enable"
fi

TCP_ENABLE=$APLOG_DIR/tcplog.enable
if [ -e $TCP_ENABLE ]; then
    [ -d $WLAN_DIR ] && cp -a $WLAN_DIR $APLOG_DIR/wlan
    [ -d $APLOG_DIR/wlan/logs ] && rm -rf $APLOG_DIR/wlan/logs
    /system/bin/iwpriv wlan0 version > $APLOG_DIR/wlan/wlan_version.txt
    Log "Collecting wlan driver logs done"
else
    Log "Collecting wlan driver logs NOT enable"
fi

[ -e $TMLOG_DIR ] && cp -a $TMLOG_DIR $APLOG_DIR
[ -e $TMLOG_DIR ] && cp -a $TMLOG_ALL_DIR $APLOG_DIR
[ -e $DDR_ID ] && cat $DDR_ID > $APLOG_DIR/ddr_id

# add for settings info.
#[ -e /data/system/users/0/settings_global.xml ] && cp /data/system/users/0/settings_global.xml $APLOG_DIR/
#[ -e /data/system/users/0/settings_secure.xml ] && cp /data/system/users/0/settings_secure.xml $APLOG_DIR/
#[ -e /data/system/users/0/settings_system.xml ] && cp /data/system/users/0/settings_system.xml $APLOG_DIR/
#Log "Collecting settings info done"

if [ -e /d/le_rkm ]; then
    date > $LASTKMSG_LOGFILE
    echo "" >> $LASTKMSG_LOGFILE
    cat /d/le_rkm/last_kmsg >> $APLOG_DIR/last_kmsg
    Log "Collecting last_kmsg done"

    data > $LKMSG_LOGFILE
    echo "" >> $LKMSG_LOGFILE
    cat /d/le_rkm/lk_mesg > $APLOG_DIR/lk_mesg
    Log "Collecting lk_mesg done"

    data > $XBLMSG_LOGFILE
    echo "" >> $XBLMSG_LOGFILE
    cat /d/le_rkm/sbl1_mesg > $APLOG_DIR/sbl1_mesg
    Log "Collecting sbl1_mesg done"
fi

# add for reboot log need by bsp
PSTORE_DIR=/sys/fs/pstore
[ -d $PSTORE_DIR ] && cp -a $PSTORE_DIR/ $APLOG_DIR/pstore

BL_LOGFILE=$APLOG_DIR/BL
date  >> $BL_LOGFILE
echo "" >> $BL_LOGFILE
cat /dev/block/bootdevice/by-name/logfs >> $BL_LOGFILE
Log "Collecting bootdevice logs done"

RAWDUMP_LOGFILE=$APLOG_DIR/rawdump
if [ $(getprop persist.vendor.dloadmode.config) = 0 ]; then
   cat /dev/block/bootdevice/by-name/rawdump >> $RAWDUMP_LOGFILE
   Log "Collecting rawdump logs done"
fi

# collect package list generate by feedback
if [ -e /sdcard/log/packagelist.txt ]; then
    cp /sdcard/log/packagelist.txt $APLOG_DIR/
    Log "Collecting packagelist.txt"
fi

# collect package list generate by SecretCode
if [ -e /sdcard/log/packagelist_SecretCode.txt ]; then
    cp /sdcard/log/packagelist_SecretCode.txt $APLOG_DIR/
    Log "Collecting packagelist_SecretCode.txt"
fi

ps -A > $APLOG_DIR/ps.txt
Log "collecting ps done"
#if [ $(getprop persist.sys.aplogfiles) -gt 0 ]; then
#    dumpsys netstats --full --uid --tag > $APLOG_DIR/dumpsys_netstats
#    Log "Collecting bugreport info start"
#    bugreport > $APLOG_DIR/bugreport.txt
#    Log "Collecting bugreport info done"
#else
#    Log "Collecting dumpsys info start"
#    dumpsys activity -a > $APLOG_DIR/dumpsys_activity
#    dumpsys netstats --full --uid --tag > $APLOG_DIR/dumpsys_netstats

#for dumpsyslog in alarm appops package location battery batterystats power audio window notification meminfo display media.audio_policy cpuinfo sensorservice deviceidle; do
#        dumpsys $dumpsyslog > $APLOG_DIR/dumpsys_$dumpsyslog
#done

#Log "Collecting dumpsys info end"
#fi

# get ipinfo for modem need
CollectIpinfo

# If log service running, should stop them before copy log files, and then restart.
for svc in batterylog mainlog mainlog_big radiolog radiolog_big kernellog eventslog eventslog_big; do
    eval ${svc}=$(getprop init.svc.${svc})
    if eval [ "\$$svc" = "running" ]; then
        stop $svc
    fi
done

# wait for stop services done.
wait
Log "Stop log services done"
chmod -R 777 $APLOG_DIR
Log "chmod -R 777 aplog dir"
mkdir -p /sdcard/log
Log "make tar package start"
FILENAME=aplog_$(date +%Y_%m_%d_%H_%M_%S)
tar zcf /data/vendor/newlog/${FILENAME}.tgz -C ${APLOG_DIR}/../ aplog
wait
Log "make tar package done"

# remove history log.
rm -rf $APLOG_DIR/tombstones/*
rm -rf $APLOG_DIR/bluetooth/*
rm -rf $APLOG_DIR/anr/*
rm -rf $APLOG_DIR/gps/*
rm -rf $APLOG_DIR/recovery/*
rm -rf $APLOG_DIR/wlan/*
rm -rf $APLOG_DIR/tcps/*
rm -rf $APLOG_DIR/logcats/*
rm -rf $APLOG_DIR/dumpsys/*
rm -rf $APLOG_DIR/pstore/*
rm -rf $APLOG_DIR/dropbox/*

# remove files except '*.enable'
rm -f $APLOG_DIR/!(*.enable)
Log "Remove history logs done"

# clean logcat system buffer
#vendor_logcat -c
#vendor_logcat -b radio -c
#vendor_logcat -b events -c
#Log "clean logcat buffer done"

#clean anr, recovery, tombstones history files
#rm -f /cache/recovery/*
#rm -f /data/anr/*
#rm -f /data/tombstones/*
#rm -rf /data/tombstones/dsps/*
#rm -rf /data/tombstones/lpass/*
#rm -rf /data/tombstones/modem/*
#rm -rf /data/tombstones/wcnss/*
#Log "clean anr, tombstones history files done"

for svc in batterylog mainlog mainlog_big radiolog radiolog_big kernellog eventslog eventslog_big; do
    if eval [ "\$$svc" = "running" ]; then
        start $svc
    fi
done

# wait for start services done
wait
Log "Restart log services done"
Log "copy_aplog done, tar package is ${FILENAME}.tgz"

