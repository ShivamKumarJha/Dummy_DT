#!/system/bin/sh
#
# Copyright (c) 2017, Motorola LLC  All rights reserved.
#
# The UFS FFU update scripts for SKhynix ufs


SCRIPT=${0#/system/bin/}

# main()

VENDOR=`cat /sys/block/sda/device/vendor | tr -d ' '`
MODEL=`cat /sys/block/sda/device/model | tr -d ' '`
echo "$SCRIPT: UFS Model: $MODEL" > /dev/kmsg
REV=`cat /sys/block/sda/device/rev`
echo "$SCRIPT: Product Revision: $REV" > /dev/kmsg
UPGRADE_NEEDED=0

if [ "$MODEL" == "H28U74301AMR" ] ; then
	if [ "$REV" != "D003" ] ; then
		UPGRADE_NEEDED=1
	fi
fi

if [ "$UPGRADE_NEEDED" == "0" ] ; then
	echo "$SCRIPT: Result: PASS" > /dev/kmsg
	echo "$SCRIPT: no action required" > /dev/kmsg
	exit
fi

# the firmware file name format needs to be "vendor-model-size.fw"
FW_FILE=/system/etc/firmware/$VENDOR-$MODEL-64G.fw

echo "$SCRIPT: firmware is $FW_FILE" > /dev/kmsg

if [ -e $FW_FILE ]; then
	echo "$SCRIPT Start to do UFS FFU: $FW_FILE" > /dev/kmsg
	/system/xbin/sg_write_buffer -v -m dmc_offs_defer -I $FW_FILE  /dev/block/sda

	if [ $? -eq "0" ];then
		echo "$SCRIPT UFS $FW_FILE updated done, reboot now !" > /dev/kmsg
		sleep 1
		echo b >/proc/sysrq-trigger
	else
		echo " $SCRIPT fails to send $FW_FILE " > /dev/kmsg
	fi
	exit
fi
