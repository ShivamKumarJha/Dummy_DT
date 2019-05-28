#!/vendor/bin/sh
gesture_type=`getprop persist.asus.gesture.type`
echo "$gesture_type" > /sys/bus/i2c/devices/i2c-4/4-0038/fts_gesture_mode

