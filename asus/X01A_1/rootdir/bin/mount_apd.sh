#!/vendor/bin/sh

# This service is for ASUS Product Demo

#mount -t ext4 /dev/block/platform/mtk-msdc.0/11230000.msdc0/by-name/APD /APD noatime,nosuid,nodev,noauto_da_alloc,discard wait,check,formattable >> $LOG_DIR/mount_apd.txt 2>&1
# We chown/chmod ADF/ADF again so because mount is run as root + defaults

chown -R system:system /APD
chmod -R 0775 /APD
chown -R system:system /ADF
chmod -R 0775 /ADF