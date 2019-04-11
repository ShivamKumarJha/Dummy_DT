#! /system/bin/sh
brightness=($(cat /sys/class/backlight/panel0-backlight/brightness))
if [ $brightness -eq 0 ];
then
    echo "backlight is 0,pls do tp_selftest when screen on"
    echo "TEST_FAIL"
        exit
fi
if [ -f /sys/bus/i2c/devices/2-0049/stm_fts_cmd ];
then
        echo "ST"
else
        echo "TEST_FAIL"
        exit
fi

for i in $(seq 0 3); do
    echo 00 > /sys/bus/i2c/devices/2-0049/stm_fts_cmd
    test_result=$(cat /sys/bus/i2c/devices/2-0049/stm_fts_cmd)
    if  [ "$test_result" == "{ 00000000 }" ]; then
        echo "TEST_PASS"
        break
    else
        if [ $i -eq 2 ]; then
            echo "56 01 03">/proc/fts/driver_test
            echo "13 1">/proc/fts/driver_test
            echo 1 > /sys/bus/i2c/devices/2-0049/hover_tune
            continue
        fi
        if [ $i -eq 3 ]; then
            echo "TEST_FAIL"
            break
        fi
    fi
done

mkdir -p /data/misc/tp_selftest_data
echo $test_result >> /data/misc/tp_selftest_data/result.txt
