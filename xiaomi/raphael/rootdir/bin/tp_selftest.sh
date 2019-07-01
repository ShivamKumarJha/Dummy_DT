#! /system/bin/sh
brightness=($(cat /sys/class/backlight/panel0-backlight/brightness))
if [ $brightness -eq 0 ];
then
    echo "backlight is 0,pls do tp_selftest when screen on"
    echo "TEST_FAIL"
        exit
fi
if [ -f /sys/bus/platform/devices/goodix_ts.0/tp_test ];
then
        echo "GOODIX"
else
        echo "TEST_FAIL"
        exit
fi

for i in $(seq 0 3); do
    test_result=$(cat /sys/bus/platform/devices/goodix_ts.0/tp_test)
    if  [ "$test_result" == "1" ]; then
        echo "TEST_PASS"
        break
    else
        if [ $i -eq 3 ]; then
            echo "TEST_FAIL"
            break
        fi
    fi
done

mkdir -p /data/misc/tp_selftest_data
echo $test_result >> /data/misc/tp_selftest_data/result.txt
