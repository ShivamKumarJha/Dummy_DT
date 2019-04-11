#! /system/bin/sh
IMEI="000000"
IMEI=$(getprop persist.radio.imei)
echo $IMEI
mkdir -p /data/misc/tp_selftest_data
FILE_NAME=/data/misc/tp_selftest_data/${IMEI}".csv"
echo $FILE_NAME
cat /sys/bus/i2c/devices/2-0049/selftest_info >> $FILE_NAME
cat /sys/bus/i2c/devices/2-0049/ms_raw >> $FILE_NAME
cat /sys/bus/i2c/devices/2-0049/ms_cx_total >> $FILE_NAME
cat /sys/bus/i2c/devices/2-0049/ss_raw >> $FILE_NAME
cat /sys/bus/i2c/devices/2-0049/ss_ix_total >> $FILE_NAME
cat /sys/bus/i2c/devices/2-0049/ss_hover >> $FILE_NAME

