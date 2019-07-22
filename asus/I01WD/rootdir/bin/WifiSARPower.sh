ReceiverOn=`getprop vendor.asus.sar.audio`
Wifion=`getprop wlan.driver.status`
Country=`getprop vendor.asus.operator.iso-country`
SKU=`getprop ro.boot.id.rf_2`
#CustomerID=`getprop ro.config.CID`
#Wigigon=`getprop vendor.wigig.driver.status`
#Softapon=`getprop wlan.softap.driver.status`

log -t WifiSARPower enter ReceiverOn=$ReceiverOn Wifion=$Wifion Country=$Country SKU=$SKU

case "$Wifion" in
    "ok")
        if [ "$ReceiverOn" == "1" ] && [ "$SKU" == "7" ] ; then
            case "$Country" in
                *"US"* )
                    vendor_cmd_tool -f /vendor/bin/sar-vendor-cmd.xml -i wlan0 --START_CMD --SAR_SET --ENABLE 0 --NUM_SPECS 0 --END_CMD
                    log -t WifiSARPower SAR_SET ENABLE 0
                ;;
            esac
        elif [ "$ReceiverOn" == "1" ]; then
            case "$Country" in
                *"IN"* )
                    vendor_cmd_tool -f /vendor/bin/sar-vendor-cmd.xml -i wlan0 --START_CMD --SAR_SET --ENABLE 0 --NUM_SPECS 0 --END_CMD
                    log -t WifiSARPower SAR_SET ENABLE 0
                ;;
            esac
        else
                vendor_cmd_tool -f /vendor/bin/sar-vendor-cmd.xml -i wlan0 --START_CMD --SAR_SET --ENABLE 5 --NUM_SPECS 0 --END_CMD
                log -t WifiSARPower SAR_SET ENABLE 5
        fi
    ;;
    "unloaded")
            vendor_cmd_tool -f /vendor/bin/sar-vendor-cmd.xml -i wlan0 --START_CMD --SAR_SET --ENABLE 5 --NUM_SPECS 0 --END_CMD
            log -t WifiSARPower SAR_SET ENABLE 5
    ;;
esac
