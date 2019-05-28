#!/system/bin/sh

enable=`getprop persist.google.assistant.enable`
echo [asus]persist.google.assistant.enable=$enable

if [ $enable == "0" ] ; then
	echo 0 > /sys/devices/platform/soc/soc\:asustek_googlekey/googlekey_enable
elif [ $enable == "1" ]; then
	echo 1 > /sys/devices/platform/soc/soc\:asustek_googlekey/googlekey_enable
elif [ $enable == "2" ]; then
	echo 2 > /sys/devices/platform/soc/soc\:asustek_googlekey/googlekey_enable
fi
