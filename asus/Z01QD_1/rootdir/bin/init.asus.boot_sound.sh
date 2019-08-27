#!/vendor/bin/sh

echo "booting sound" > /dev/kmsg

if test -e "/vendor/asdf/boot_sound_enabled"; then
    echo "boot_sound_enabled exists" > /dev/kmsg
else
    echo 1 > /vendor/asdf/boot_sound_enabled
fi

enabled=`cat /vendor/asdf/boot_sound_enabled`
echo "boot_sound_enabled = $enabled" > /dev/kmsg

if [ "$enabled" == "1" ]; then
    if [ -e /vendor/asdf/boot_sound_vol_index ]; then
        vol_index=`cat /vendor/asdf/boot_sound_vol_index`
    else
        vol_index=5
    fi

    i=0
    while [ -e /proc/asound/card${i} ]
    do
        card_id=`cat /proc/asound/card${i}/id`
        if [ "$card_id" == "sdm845tavilsndc" ]; then
            card=$i
            echo "get sound card $card" > /dev/kmsg
            break
        fi
        i=$(($i+1))
    done

    if [ -n "$card" ] && [ "$vol_index" -ne 0 ]; then
        echo "play boot sound with volume index $vol_index" > /dev/kmsg
        sleep 1.9
        /system/bin/tinymix -D ${card} 'TFA_CHIP_SELECTOR' '0'
        /system/bin/tinymix -D ${card} 'QUAT_MI2S_RX Audio Mixer MultiMedia1' '1'
        /system/bin/tinyplay /vendor/etc/boot_sound/boot_sound_${vol_index}.wav -D ${card}
        sleep 0.5
        /system/bin/tinymix -D ${card} 'QUAT_MI2S_RX Audio Mixer MultiMedia1' '0'
    fi
fi

setprop 'sys.asus.boot_sound.completed' '1'
