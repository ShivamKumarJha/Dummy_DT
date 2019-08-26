#! /vendor/bin/sh

cei_fp_id=`cat /proc/cei_fp_id`

if [ -n $cei_fp_id ]; then
	setprop vendor.hw.fingerprint $cei_fp_id
else
	setprop vendor.hw.fingerprint Unknown
fi

if [ -n $cei_fp_id ]; then
        setprop vendor.fingerprint.hwid $cei_fp_id
else
        setprop vendor.fingerprint.hwid Unknown
fi

