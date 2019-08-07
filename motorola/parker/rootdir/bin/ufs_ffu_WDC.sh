#!/vendor/bin/sh
#
# Copyright (c) 2013-2019, Motorola LLC  All rights reserved.
#
# The UFS FFU update scripts for Samsung ufs


SCRIPT=${0#/vendor/bin/}

# function: print log into kmsg
kmsg_print() {
	echo "$SCRIPT: $1" > /dev/kmsg
}

# main()

VENDOR="WDC"
MODEL=`/vendor/bin/cat /sys/block/sda/device/model | tr -d ' '`
REV=`/vendor/bin/cat /sys/block/sda/device/rev`
UPGRADE_NEEDED=0

if [ "$MODEL" == "KLUBG4G1CE-B0B1" -o "$MODEL" == "KLUCG4J1CB-B0B1" ] ; then
	UFS_SIZE="32G"
	if [ "$REV" -lt "0800" ] ; then
		UPGRADE_NEEDED=1
	fi
elif [ "$MODEL" == "SDINDDC4-128G" ] ; then
	UFS_SIZE="128G"
	if [ "$REV" -eq "1076" ] ; then
		UPGRADE_NEEDED=1
	fi
fi

kmsg_print "Vendor: $VENDOR"
kmsg_print "Model: $MODEL"
kmsg_print "Size: $UFS_SIZE"
kmsg_print "Revision: $REV"

if [ "$UPGRADE_NEEDED" == "0" ] ; then
	kmsg_print "Result: PASS. No action required"
	exit
fi

# the firmware file name format needs to be "vendor-model-size.fw"
FW_FILE=/vendor/firmware/$VENDOR-$MODEL-$UFS_SIZE.fw
kmsg_print "firmware is $FW_FILE"

if [ -e $FW_FILE ]; then
	kmsg_print "Start to do UFS FFU:"
	/vendor/bin/sync
 	/vendor/bin/setprop vendor.ufs_need_ffu 1
fi