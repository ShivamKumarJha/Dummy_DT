#! /vendor/bin/sh


# add for fingerprint
# ZTE_FINGERPRINT_DEFAULT_FPC
default_fpc_chip=`getprop ro.feature.zte_fingerprint_default_fpc`
# ZTE_FINGERPRINT_DEFAULT_SILEAD
default_silead_chip=`getprop ro.feature.zte_fingerprint_default_silead`
# ZTE_FINGERPRINT_DEFAULT_GOODIX_GF95XX
default_gf95xx_chip=`getprop ro.feature.zte_fingerprint_default_goodix_gf95xx`
if [ "$default_fpc_chip" = "1" ]; then
    default_chip="fpc1028"
elif [ "$default_silead_chip" = "1" ]; then
    default_chip="silead"
elif [ "$default_gf95xx_chip" = "1" ]; then
    default_chip="gf95xx"
else
    default_chip="goodix"
fi

finger_id=`cat /sys/module/zte_misc/parameters/fingerprint_hw`
if [ "$finger_id" = "128" ]; then
    setprop vendor.fingerprint.id  "silead"
elif [ "$finger_id" = "5" ] || [ "$finger_id" = "4" ]; then
    setprop vendor.fingerprint.id  "gf3238"
elif [ "$finger_id" = "32" ]; then
    setprop vendor.fingerprint.id  "synafp"
elif [ "$finger_id" = "64" ]; then
    setprop vendor.fingerprint.id  "fpc"
elif [ "$finger_id" = "65" ]; then
    setprop vendor.fingerprint.id  "fpc1028"
else
    setprop vendor.fingerprint.id  $default_chip
fi
# end to add for fingerprint