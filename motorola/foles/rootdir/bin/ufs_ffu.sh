#!/vendor/bin/sh
#

SCRIPT=${0#/system/bin/}

vendor=`/vendor/bin/cat /sys/block/sda/device/vendor | tr -d ' '`

# If we have an upgrade script for this manufactuer, execute it.
if [ -x /vendor/bin/ufs_ffu_${vendor}.sh ] ; then
	/vendor/bin/sh /vendor/bin/ufs_ffu_${vendor}.sh
else
	echo "Manufacturer: $vendor"
	echo "Result: PASS"
	echo "$SCRIPT: no action required" > /dev/kmsg
fi
