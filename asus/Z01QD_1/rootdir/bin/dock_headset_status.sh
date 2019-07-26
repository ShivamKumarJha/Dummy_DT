#!/vendor/bin/sh

dock_headset_usbid="0bda:4a44"
card_max=3

for i in $(seq 0 $card_max)
do
    if [ ! -e "/proc/asound/card${i}/usbid" ]; then
        continue
    fi
    usbid=`cat /proc/asound/card${i}/usbid` > /dev/null 2>&1
    if [ "$usbid" == "$dock_headset_usbid" ]; then
        state=`cat /proc/asound/card${i}/state` > /dev/null 2>&1
        if [ "$state" == "ONLINE" ]; then
            if [ -d "/proc/asound/card${i}/pcm0c" ]; then
                echo "1"
            else
                echo "0"
            fi
        else
            echo "0"
        fi
        break
    fi
done

if [ $i -eq $card_max ]; then
    echo "0"
fi
