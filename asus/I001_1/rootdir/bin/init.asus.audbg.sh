#!/vendor/bin/sh
audbg_mode=`getprop persist.vendor.asus.audbg`
echo "$audbg_mode" > /proc/driver/audio_debug
