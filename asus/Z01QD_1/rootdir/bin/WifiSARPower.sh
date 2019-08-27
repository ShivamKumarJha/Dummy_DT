ReceiverOn=`getprop sys.asus.sar.audio`
Wifion=`getprop wlan.driver.status`
Country=`getprop gsm.operator.iso-country`
CustomerID=`getprop ro.config.CID`
Wigigon=`getprop vendor.wigig.driver.status`
Softapon=`getprop wlan.softap.driver.status`

log -t WifiSARPower enter ReceiverOn=$ReceiverOn Wifion=$Wifion Country=$Country CustomerID=$CustomerID Wigigon=$Wigigon Softapon=$Softapon

if [ "$Wigigon" == "ok" ] ; then
    case "$Wifion" in
        "ok")
            if [ "$ReceiverOn" == "1" ] || [ "$Softapon" == "ok" ] ; then
                case "$Country" in
                    *"us"* | *"in"* )
                        vendor_cmd_tool -f /data/data/sar-vendor-cmd.xml -i wlan0 --START_CMD --SAR_SET --ENABLE 1 --NUM_SPECS 0 --END_CMD
                        log -t WifiSARPower SAR_SET ENABLE 1
                    ;;
                    *"ca"* )
                        if [ "$ReceiverOn" == "1" ] ; then
                        vendor_cmd_tool -f /data/data/sar-vendor-cmd.xml -i wlan0 --START_CMD --SAR_SET --ENABLE 0 --NUM_SPECS 0 --END_CMD
                        log -t WifiSARPower SAR_SET ENABLE 0
                        elif [ "$Softapon" == "ok" ] ; then
                            vendor_cmd_tool -f /data/data/sar-vendor-cmd.xml -i wlan0 --START_CMD --SAR_SET --ENABLE 1 --NUM_SPECS 0 --END_CMD
                            log -t WifiSARPower SAR_SET ENABLE 1
                        fi
                    ;;
                esac
            else
                vendor_cmd_tool -f /data/data/sar-vendor-cmd.xml -i wlan0 --START_CMD --SAR_SET --ENABLE 5 --NUM_SPECS 0 --END_CMD
                log -t WifiSARPower SAR_SET ENABLE 5
            fi
        ;;
        "unloaded")
            if [ "$Softapon" == "ok" ] ; then
                case "$Country" in
                    *"us"* | *"in"* )
                        vendor_cmd_tool -f /data/data/sar-vendor-cmd.xml -i wlan0 --START_CMD --SAR_SET --ENABLE 1 --NUM_SPECS 0 --END_CMD
                        log -t WifiSARPower SAR_SET ENABLE 1
                    ;;
                    *"ca"* )
                        if [ "$ReceiverOn" == "1" ] ; then
                            vendor_cmd_tool -f /data/data/sar-vendor-cmd.xml -i wlan0 --START_CMD --SAR_SET --ENABLE 0 --NUM_SPECS 0 --END_CMD
                            log -t WifiSARPower SAR_SET ENABLE 0
                        else
                        vendor_cmd_tool -f /data/data/sar-vendor-cmd.xml -i wlan0 --START_CMD --SAR_SET --ENABLE 1 --NUM_SPECS 0 --END_CMD
                        log -t WifiSARPower SAR_SET ENABLE 1
                        fi
                    ;;
                esac
            else
                vendor_cmd_tool -f /data/data/sar-vendor-cmd.xml -i wlan0 --START_CMD --SAR_SET --ENABLE 5 --NUM_SPECS 0 --END_CMD
                log -t WifiSARPower SAR_SET ENABLE 5
            fi
        ;;
    esac
else
    case "$Wifion" in
        "ok")
            if [ "$ReceiverOn" == "1" ] || [ "$Softapon" == "ok" ] ; then
                case "$Country" in
                    *"us"* | *"ca"* | *"in"* )
                        vendor_cmd_tool -f /data/data/sar-vendor-cmd.xml -i wlan0 --START_CMD --SAR_SET --ENABLE 1 --NUM_SPECS 0 --END_CMD
                        log -t WifiSARPower SAR_SET ENABLE 1
                    ;;
                esac
            else
                    vendor_cmd_tool -f /data/data/sar-vendor-cmd.xml -i wlan0 --START_CMD --SAR_SET --ENABLE 5 --NUM_SPECS 0 --END_CMD
                    log -t WifiSARPower SAR_SET ENABLE 5
            fi
        ;;
        "unloaded")
            if [ "$Softapon" == "ok" ] ; then
                case "$Country" in
                    *"us"* | *"ca"* | *"in"* )
                        vendor_cmd_tool -f /data/data/sar-vendor-cmd.xml -i wlan0 --START_CMD --SAR_SET --ENABLE 1 --NUM_SPECS 0 --END_CMD
                        log -t WifiSARPower SAR_SET ENABLE 1
                    ;;
                esac
            else
                vendor_cmd_tool -f /data/data/sar-vendor-cmd.xml -i wlan0 --START_CMD --SAR_SET --ENABLE 5 --NUM_SPECS 0 --END_CMD
                log -t WifiSARPower SAR_SET ENABLE 5
            fi
        ;;
    esac
fi
