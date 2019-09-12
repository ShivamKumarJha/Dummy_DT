#!/system/bin/sh
setprop ro.btmac `btnvtool -x 2>&1`
setprop bt.version.driver `qcfwver`
wifi_mac=`sed -n '1 p' /vendor/factory/wlan_mac.bin`
wifi_mac=${wifi_mac//Intf0MacAddress=/ }
setprop ro.wifimac $wifi_mac
wifi_mac=`sed -n '2 p' /vendor/factory/wlan_mac.bin`
wifi_mac=${wifi_mac//Intf1MacAddress=/ }
setprop ro.wifimac_2 $wifi_mac

wigig_mac=`cat /vendor/factory/wigig_mac.bin`
setprop ro.wigigmac $wigig_mac

setprop wifi.version.driver WLAN.HL.3.0-02339-QCAHLSWMTPLZ-1.207561.1.212040.1
