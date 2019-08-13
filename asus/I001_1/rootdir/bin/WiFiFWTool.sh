#!/vendor/bin/sh

ADD_INI=`getprop persist.vendor.asus.wlanfwdbgini`
WLANDBG=`getprop persist.vendor.asus.wlanfwdbg`

log -t WiFiFWTool WLANDBG=$WLANDBG ADD_INI=$ADD_INI

if [ "$WLANDBG" = "1" ];then
	if [ "$ADD_INI" = "" ];then
		log -t WiFiFWTool enable_fwdbug but Prop. is empty
		echo -n "disable" > /sys/module/icnss/parameters/do_wlan_fw_adddebugini;
	else
		log -t WiFiFWTool enable_fwdbg
		echo -n "$ADD_INI" > /sys/module/icnss/parameters/do_wlan_fw_adddebugini;
	fi
elif [ "$WLANDBG" = "0" ];then
	log -t WiFiFWTool disable_fwdbg
	echo -n "disable" > /sys/module/icnss/parameters/do_wlan_fw_adddebugini;
else
	log -t WiFiFWTool unknown parameters
fi

