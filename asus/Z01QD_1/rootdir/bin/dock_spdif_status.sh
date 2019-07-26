#!/vendor/bin/sh

dock_headset_usbid="0bda:4a44"
dock_spdif_usbid="0bda:4917"
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
            if [ -d "/proc/asound/card${i}/pcm0p" ]; then
                dock_headset_card=$i
            fi
        fi
    elif [ "$usbid" == "$dock_spdif_usbid" ]; then
        state=`cat /proc/asound/card${i}/state` > /dev/null 2>&1
        if [ "$state" == "ONLINE" ]; then
            if [ -d "/proc/asound/card${i}/pcm0p" ]; then
                dock_spdif_card=$i
            fi
        fi
    fi
done

if [ -n "$dock_spdif_card" ]; then
    if [ -n "$dock_headset_card" ]; then
        echo "1"
    else
        echo "2"
    fi
else
    echo "0"
fi
