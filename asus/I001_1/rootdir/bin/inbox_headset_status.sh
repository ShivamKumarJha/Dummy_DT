#!/vendor/bin/sh

inbox_card_id="U5683"
inbox_state=`cat /proc/asound/$inbox_card_id/state` > /dev/null 2>&1

if [ "$inbox_state" == "ONLINE" ]; then
    if [ -d "/proc/asound/$inbox_card_id/pcm0p" ]; then
        if [ -d "/proc/asound/$inbox_card_id/pcm0c" ]; then
            echo "1"
        else
            echo "2"
        fi
    else
        echo "3"
    fi
else
    echo "0"
fi
