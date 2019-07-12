#!/system/bin/sh

#wifisar.sh 
gSAR_enabled=0
while true ; do
	wlan_driver_status=$(getprop wlan.driver.status)
	wifi_sar=$(getprop sys.wifi.sar)
	if [ "$wlan_driver_status" != "ok" ]; then
	    echo "WiFi SAR disabled because WLAN driver status is $wlan_driver_status" > /dev/kmsg
	    break
	fi
	if [ "$wifi_sar" != "1" ]; then
	    echo "WiFi SAR disabled because wifi_sar flag is $wifi_sar" > /dev/kmsg
		break
	fi
	if [ $gSAR_enabled -eq 0 ]; then
	    /system/vendor/bin/vendor_cmd_tool_LA1.1 -f /system/etc/wifi/sar/sar-vendor-cmd.xml -i wlan0 --START_CMD --SAR_SET --ENABLE 6 --NUM_SPECS 6 --SAR_SPEC --NESTED_AUTO --BAND 0 --CHAIN 0 --MOD 0 --POW 33 --END_ATTR --NESTED_AUTO --BAND 0 --CHAIN 1 --MOD 0 --POW 33 --END_ATTR --NESTED_AUTO --BAND 0 --CHAIN 0 --MOD 1 --POW 33 --END_ATTR --NESTED_AUTO --BAND 0 --CHAIN 1 --MOD 1 --POW 33 --END_ATTR --NESTED_AUTO --BAND 1 --CHAIN 0 --MOD 1 --POW 26 --END_ATTR --NESTED_AUTO --BAND 1 --CHAIN 1 --MOD 1 --POW 26 --END_ATTR --END_ATTR --END_CMD
	    gSAR_enabled=1
	    echo "WiFi SAR enabled" > /dev/kmsg
	fi
	sleep 0.5
done
/system/vendor/bin/vendor_cmd_tool_LA1.1 -f /system/etc/wifi/sar/sar-vendor-cmd.xml -i wlan0 --START_CMD --SAR_SET --ENABLE 5 --NUM_SPECS 0 --END_CMD
