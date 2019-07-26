#!/vendor/bin/sh

station_card_id="Audio"
station_state=`cat /proc/asound/$station_card_id/state` > /dev/null 2>&1

if [ "$station_state" == "ONLINE" ]; then
    if [ -d "/proc/asound/$station_card_id/pcm0p" ]; then
        if [ -d "/proc/asound/$station_card_id/pcm0c" ]; then
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
