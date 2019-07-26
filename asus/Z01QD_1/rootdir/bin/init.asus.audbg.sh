#!/vendor/bin/sh
audbg_mode=`getprop persist.asus.audbg`
echo "$audbg_mode" > /proc/driver/audio_debug
