#!/system/bin/sh
TP_VER_PACK=`cat /sys/bus/i2c/devices/4-0038/fts_fw_version`

setprop touch.version.driver "$TP_VER_PACK"
