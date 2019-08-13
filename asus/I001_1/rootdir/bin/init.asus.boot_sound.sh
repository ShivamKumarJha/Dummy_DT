#!/vendor/bin/sh

echo "boot_sound" > /dev/kmsg

if test -e "/asdf/boot_sound_enabled"; then
    echo "boot_sound: boot_sound_enabled exists" > /dev/kmsg
else
    echo 1 > /asdf/boot_sound_enabled
fi

enabled=`cat /asdf/boot_sound_enabled`
echo "boot_sound: boot_sound_enabled = $enabled" > /dev/kmsg
property=`getprop ro.product.model`

if [ "$property" == "ASUS_I001DA" ] || [ "$property" == "ASUS_I001DB" ]; then
boot_sound_file="/vendor/etc/boot_sound/boot_sound_3.wav"
else
boot_sound_file="/vendor/etc/boot_sound/boot_sound_3.wav"
fi

vol_index=`cat /asdf/boot_sound_vol_index`
echo "boot_sound: boot_sound_vol_index = $vol_index" > /dev/kmsg
echo "boot_sound_file = $boot_sound_file" > /dev/kmsg
echo "boot_sound property=$property" > /dev/kmsg

if [ "$enabled" == "1" ] && [ "$vol_index" != "0" ]; then
    sleep 1.5

    i=0
    while [ -e /proc/asound/card${i} ]
    do
        if [ -e /proc/asound/card${i}/usbid ]; then
            card_id=`cat /proc/asound/card${i}/id`
            if [ "$card_id" == "U5683" ] || [ "$card_id" == "JEDI" ]; then
                echo "boot_sound: found ACCY usb sound card" > /dev/kmsg
            else
                snd_card_usb=$i
                echo "boot_sound: found usb sound card $snd_card_usb" > /dev/kmsg
            fi
        else
            card_id=`cat /proc/asound/card${i}/id`
            if [ "$card_id" == "sm8150tavilsndc" ]; then
                snd_card_tavil=$i
                echo "boot_sound: found tavil sound card $snd_card_tavil" > /dev/kmsg
            fi
        fi
        i=$(($i+1))
    done

    headset_status=`cat /proc/driver/audio_debug`
    echo "boot_sound: headset_status = $headset_status" > /dev/kmsg

    if [ -n "$snd_card_tavil" ] ; then
        if [ -n "$snd_card_usb" ] ; then
            echo "boot_sound: play boot sound from usb headset" > /dev/kmsg
            sleep 0.4
            /system/bin/tinymix -D ${snd_card_tavil} 'USB_AUDIO_RX Audio Mixer MultiMedia1' '1'
            /system/bin/tinyplay "$boot_sound_file" -D ${snd_card_tavil}
            sleep 0.5
            /system/bin/tinymix -D ${snd_card_tavil} 'USB_AUDIO_RX Audio Mixer MultiMedia1' '0'
        elif [ "$headset_status" == "1" ] || [ "$headset_status" == "2" ]; then
            echo "boot_sound: play boot sound from headset" > /dev/kmsg
            sleep 0.4
            /system/bin/tinymix -D ${snd_card_tavil} 'RX INT1_1 MIX1 INP0' 'RX2'
            /system/bin/tinymix -D ${snd_card_tavil} 'RX INT2_1 MIX1 INP0' 'RX3'
            /system/bin/tinymix -D ${snd_card_tavil} 'SLIM RX2 MUX' 'AIF4_PB'
            /system/bin/tinymix -D ${snd_card_tavil} 'SLIM RX3 MUX' 'AIF4_PB'
            /system/bin/tinymix -D ${snd_card_tavil} 'SLIM_6_RX Channels' 'Two'
            /system/bin/tinymix -D ${snd_card_tavil} 'RX1 Digital Volume' '50'
            /system/bin/tinymix -D ${snd_card_tavil} 'RX2 Digital Volume' '50'
            /system/bin/tinymix -D ${snd_card_tavil} 'SLIMBUS_6_RX Audio Mixer MultiMedia1' '1'
            /system/bin/tinyplay "$boot_sound_file" -D ${snd_card_tavil}
            sleep 0.5
            /system/bin/tinymix -D ${snd_card_tavil} 'SLIMBUS_6_RX Audio Mixer MultiMedia1' '0'
            /system/bin/tinymix -D ${snd_card_tavil} 'RX INT1_1 MIX1 INP0' 'ZERO'
            /system/bin/tinymix -D ${snd_card_tavil} 'RX INT2_1 MIX1 INP0' 'ZERO'
            /system/bin/tinymix -D ${snd_card_tavil} 'SLIM RX2 MUX' 'ZERO'
            /system/bin/tinymix -D ${snd_card_tavil} 'SLIM RX3 MUX' 'ZERO'
            /system/bin/tinymix -D ${snd_card_tavil} 'RX1 Digital Volume' '84'
            /system/bin/tinymix -D ${snd_card_tavil} 'RX2 Digital Volume' '84'
        else
            echo "boot_sound: play boot sound from speaker" > /dev/kmsg
            sleep 0.4
            /system/bin/tinymix -D ${snd_card_tavil} 'TFA_CHIP_SELECTOR' '0'
            /system/bin/tinymix -D ${snd_card_tavil} 'QUAT_MI2S_RX Audio Mixer MultiMedia1' '1'
            /system/bin/tinyplay "$boot_sound_file" -D ${snd_card_tavil}
            sleep 0.5
            /system/bin/tinymix -D ${snd_card_tavil} 'QUAT_MI2S_RX Audio Mixer MultiMedia1' '0'
        fi
    fi

    echo "boot_sound: finished" > /dev/kmsg
fi
