#! /system/bin/sh
IMEI="000000"
IMEI=$(getprop persist.radio.imei)
echo $IMEI
if [[ "$IMEI" != "^[0-9]*" ]]; then
    IMEI="000000"
fi
mkdir -p /data/misc/tp_selftest_data
FILE_NAME=/data/misc/tp_selftest_data/${IMEI}".csv"
echo $FILE_NAME
cat /sys/bus/platform/devices/goodix_ts.0/tp_rawdata > $FILE_NAME

