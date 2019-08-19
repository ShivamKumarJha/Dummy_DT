ReceiverOn=`getprop vendor.asus.sar.audio`
Wifion=`getprop wlan.driver.status`
Country=`getprop vendor.asus.operator.iso-country`
SKU=`getprop ro.boot.id.prj_2`
#CustomerID=`getprop ro.config.CID`
#Wigigon=`getprop vendor.wigig.driver.status`
Softapon=`getprop vendor.wlan.softap.driver.status`

log -t WifiSARPower enter ReceiverOn=$ReceiverOn Wifion=$Wifion Country=$Country Softapon=$Softapon SKU=$SKU

if [ "$SKU" == "2" ]; then
    case "$Wifion" in
        "ok")
            case "$Country" in
                *"US"* )
                    if [ "$ReceiverOn" == "1" ] && [ "$Softapon" == "ok" ] ; then
                        vendor_cmd_tool -f /vendor/bin/sar-vendor-cmd.xml -i wlan0 --START_CMD --SAR_SET --ENABLE 7 --NUM_SPECS 2 --SAR_SPEC --NESTED_AUTO --CHAIN 0 --POW_IDX 1 --END_ATTR --NESTED_AUTO --CHAIN 1 --POW_IDX 1 --END_ATTR --END_ATTR --END_CMD

                        log -t WifiSARPower FCC receiver on and hotspot on
                    elif [ "$ReceiverOn" == "1" ]; then
                        vendor_cmd_tool -f /vendor/bin/sar-vendor-cmd.xml -i wlan0 --START_CMD --SAR_SET --ENABLE 7 --NUM_SPECS 2 --SAR_SPEC --NESTED_AUTO --CHAIN 0 --POW_IDX 0 --END_ATTR --NESTED_AUTO --CHAIN 1 --POW_IDX 0 --END_ATTR --END_ATTR --END_CMD

                        log -t WifiSARPower FCC receiver on
                    elif [ "$Softapon" == "ok" ]; then
                        vendor_cmd_tool -f /vendor/bin/sar-vendor-cmd.xml -i wlan0 --START_CMD --SAR_SET --ENABLE 7 --NUM_SPECS 2 --SAR_SPEC --NESTED_AUTO --CHAIN 0 --POW_IDX 2 --END_ATTR --NESTED_AUTO --CHAIN 1 --POW_IDX 2 --END_ATTR --END_ATTR --END_CMD

                        log -t WifiSARPower FCC hotspot on
                    else
                        vendor_cmd_tool -f /vendor/bin/sar-vendor-cmd.xml -i wlan0 --START_CMD --SAR_SET --ENABLE 7 --NUM_SPECS 2 --SAR_SPEC --NESTED_AUTO --CHAIN 0 --POW_IDX 5 --END_ATTR --NESTED_AUTO --CHAIN 1 --POW_IDX 5 --END_ATTR --END_ATTR --END_CMD

                        log -t WifiSARPower FCC normal
                    fi
                ;;
            esac
            case "$Country" in
                *"IN"* )
                    if [ "$ReceiverOn" == "1" ] && [ "$Softapon" == "ok" ] ; then
                        vendor_cmd_tool -f /vendor/bin/sar-vendor-cmd.xml -i wlan0 --START_CMD --SAR_SET --ENABLE 7 --NUM_SPECS 2 --SAR_SPEC --NESTED_AUTO --CHAIN 0 --POW_IDX 3 --END_ATTR --NESTED_AUTO --CHAIN 1 --POW_IDX 3 --END_ATTR --END_ATTR --END_CMD

                        log -t WifiSARPower IN receiver on and hotspot on
                    elif [ "$ReceiverOn" == "1" ]; then
                        vendor_cmd_tool -f /vendor/bin/sar-vendor-cmd.xml -i wlan0 --START_CMD --SAR_SET --ENABLE 7 --NUM_SPECS 2 --SAR_SPEC --NESTED_AUTO --CHAIN 0 --POW_IDX 0 --END_ATTR --NESTED_AUTO --CHAIN 1 --POW_IDX 0 --END_ATTR --END_ATTR --END_CMD

                        log -t WifiSARPower IN receiver on
                    else
                        vendor_cmd_tool -f /vendor/bin/sar-vendor-cmd.xml -i wlan0 --START_CMD --SAR_SET --ENABLE 7 --NUM_SPECS 2 --SAR_SPEC --NESTED_AUTO --CHAIN 0 --POW_IDX 7 --END_ATTR --NESTED_AUTO --CHAIN 1 --POW_IDX 7 --END_ATTR --END_ATTR --END_CMD

                        log -t WifiSARPower IN normal
                    fi
                ;;
            esac
            case "$Country" in
                *"IT"* | *"FR"* | *"DE"* | *"UK"* | *"BE"* | *"NL"* | *"ES"* | *"DK"* | *"FI"* | *"NO"* | *"SE"* | *"PT"* |*"PL"* | *"RO"* | *"CZ"* | *"SK"* | *"HU"* | *"HK"* | *"TH"* | *"PH"* | *"SG"* )
                    if [ "$ReceiverOn" == "1" ]; then
                        vendor_cmd_tool -f /vendor/bin/sar-vendor-cmd.xml -i wlan0 --START_CMD --SAR_SET --ENABLE 7 --NUM_SPECS 2 --SAR_SPEC --NESTED_AUTO --CHAIN 0 --POW_IDX 4 --END_ATTR --NESTED_AUTO --CHAIN 1 --POW_IDX 4 --END_ATTR --END_ATTR --END_CMD

                        log -t WifiSARPower CE receiver on
                    else
                        vendor_cmd_tool -f /vendor/bin/sar-vendor-cmd.xml -i wlan0 --START_CMD --SAR_SET --ENABLE 7 --NUM_SPECS 2 --SAR_SPEC --NESTED_AUTO --CHAIN 0 --POW_IDX 7 --END_ATTR --NESTED_AUTO --CHAIN 1 --POW_IDX 7 --END_ATTR --END_ATTR --END_CMD

                        log -t WifiSARPower CE normal
                    fi
                ;;
            esac
            case "$Country" in
                *"CA"* )
                    if [ "$ReceiverOn" == "1" ] && [ "$Softapon" == "ok" ] ; then
                        vendor_cmd_tool -f /vendor/bin/sar-vendor-cmd.xml -i wlan0 --START_CMD --SAR_SET --ENABLE 7 --NUM_SPECS 2 --SAR_SPEC --NESTED_AUTO --CHAIN 0 --POW_IDX 1 --END_ATTR --NESTED_AUTO --CHAIN 1 --POW_IDX 1 --END_ATTR --END_ATTR --END_CMD

                        log -t WifiSARPower CA receiver on and hotspot on
                    elif [ "$ReceiverOn" == "1" ]; then
                        vendor_cmd_tool -f /vendor/bin/sar-vendor-cmd.xml -i wlan0 --START_CMD --SAR_SET --ENABLE 7 --NUM_SPECS 2 --SAR_SPEC --NESTED_AUTO --CHAIN 0 --POW_IDX 0 --END_ATTR --NESTED_AUTO --CHAIN 1 --POW_IDX 0 --END_ATTR --END_ATTR --END_CMD

                        log -t WifiSARPower CA receiver on
                    elif [ "$Softapon" == "ok" ]; then
                        vendor_cmd_tool -f /vendor/bin/sar-vendor-cmd.xml -i wlan0 --START_CMD --SAR_SET --ENABLE 7 --NUM_SPECS 2 --SAR_SPEC --NESTED_AUTO --CHAIN 0 --POW_IDX 2 --END_ATTR --NESTED_AUTO --CHAIN 1 --POW_IDX 2 --END_ATTR --END_ATTR --END_CMD

                        log -t WifiSARPower CA hotspot on
                    else
                        vendor_cmd_tool -f /vendor/bin/sar-vendor-cmd.xml -i wlan0 --START_CMD --SAR_SET --ENABLE 7 --NUM_SPECS 2 --SAR_SPEC --NESTED_AUTO --CHAIN 0 --POW_IDX 6 --END_ATTR --NESTED_AUTO --CHAIN 1 --POW_IDX 6 --END_ATTR --END_ATTR --END_CMD

                        log -t WifiSARPower CA normal
                    fi
                ;;
            esac
            case "$Country" in
                *"JP"* )
                        vendor_cmd_tool -f /vendor/bin/sar-vendor-cmd.xml -i wlan0 --START_CMD --SAR_SET --ENABLE 7 --NUM_SPECS 2 --SAR_SPEC --NESTED_AUTO --CHAIN 0 --POW_IDX 8 --END_ATTR --NESTED_AUTO --CHAIN 1 --POW_IDX 8 --END_ATTR --END_ATTR --END_CMD

                        log -t WifiSARPower JP normal
                ;;
            esac
        ;;
    esac
fi
