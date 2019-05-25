setprop ro.btmac `btnvtool -x 2>&1`
setprop bt.version.driver `qcfwver`
wifi_mac=`sed -n '1 p' /factory/wlan_mac.bin`
wifi_mac=${wifi_mac//Intf0MacAddress=/ }
setprop ro.wifimac $wifi_mac
setprop wifi.version.driver WLAN.HL.1.0.1.c2-00486-QCAHLSWMTPLZ-1
