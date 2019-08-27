#!/vendor/bin/sh

fqcaudio=`/vendor/bin/getprop vendor.sys.fqcaudio`
main_sound_card=0
flag0=($(cat /proc/asound/card0/id));
if [ "$flag0" = "msm8998tashasnd" ];then
    main_sound_card=0
else
    main_sound_card=1
fi

if [ "$main_sound_card" = "1" ];then
       /system/bin/tinymix -D ${main_sound_card} 'USB_AUDIO_RX dev_token' 0 > /dev/null 2>&1
       /system/bin/tinymix -D ${main_sound_card} 'USB_AUDIO_TX dev_token' 1 > /dev/null 2>&1
else
       /system/bin/tinymix -D ${main_sound_card} 'USB_AUDIO_RX dev_token' 65536 > /dev/null 2>&1
       /system/bin/tinymix -D ${main_sound_card} 'USB_AUDIO_TX dev_token' 65537 > /dev/null 2>&1
fi

case "$fqcaudio" in
    "11")
		/system/bin/tinymix -D ${main_sound_card} 'AIF1_CAP Mixer SLIM TX7' 1 > /dev/null 2>&1
		/system/bin/tinymix -D ${main_sound_card} 'SLIM TX7 MUX' 'DEC7'  > /dev/null 2>&1
		/system/bin/tinymix -D ${main_sound_card} 'ADC MUX7' 'DMIC'  > /dev/null 2>&1
		/system/bin/tinymix -D ${main_sound_card} 'DMIC MUX7' 'DMIC0'  > /dev/null 2>&1
		/system/bin/tinymix -D ${main_sound_card} 'USB_DL_HL Switch' 1  > /dev/null 2>&1
		/system/bin/tinymix -D ${main_sound_card} 'USB_AUDIO_RX Port Mixer SLIM_0_TX' 1  > /dev/null 2>&1
		/system/bin/tinyhostless -D ${main_sound_card} -P 43 -C 5 -p 1024 -n 2 -c 1 -r 48000 -T 16 -T 16 > /dev/null 2>&1 &
    ;;
    "10")
		killall -SIGINT tinyhostless > /dev/null 2>&1
		/system/bin/tinymix -D ${main_sound_card} 'AIF1_CAP Mixer SLIM TX7' 0 > /dev/null 2>&1
		/system/bin/tinymix -D ${main_sound_card} 'SLIM TX7 MUX' 'ZERO' > /dev/null 2>&1
		/system/bin/tinymix -D ${main_sound_card} 'ADC MUX7' 'AMIC' > /dev/null 2>&1
		/system/bin/tinymix -D ${main_sound_card} 'DMIC MUX7' 'ZERO' > /dev/null 2>&1
		/system/bin/tinymix -D ${main_sound_card} 'USB_DL_HL Switch' 0 > /dev/null 2>&1
		/system/bin/tinymix -D ${main_sound_card} 'USB_AUDIO_RX Port Mixer SLIM_0_TX' 0 > /dev/null 2>&1
    ;;
    "21")
		/system/bin/tinymix -D ${main_sound_card} 'AIF1_CAP Mixer SLIM TX7' 1 > /dev/null 2>&1
		/system/bin/tinymix -D ${main_sound_card} 'SLIM TX7 MUX' 'DEC7' > /dev/null 2>&1
		/system/bin/tinymix -D ${main_sound_card} 'ADC MUX7' 'DMIC' > /dev/null 2>&1
		/system/bin/tinymix -D ${main_sound_card} 'DMIC MUX7' 'DMIC2' > /dev/null 2>&1
		/system/bin/tinymix -D ${main_sound_card} 'USB_DL_HL Switch' 1 > /dev/null 2>&1
		/system/bin/tinymix -D ${main_sound_card} 'USB_AUDIO_RX Port Mixer SLIM_0_TX' 1 > /dev/null 2>&1
		/system/bin/tinyhostless -D ${main_sound_card}  -P 43 -C 5 -p 1024 -n 2 -c 1 -r 48000 -T 16 > /dev/null 2>&1 &
    ;;
    "20")
		killall -SIGINT tinyhostless > /dev/null 2>&1
		/system/bin/tinymix -D ${main_sound_card} 'AIF1_CAP Mixer SLIM TX7' 0 > /dev/null 2>&1
		/system/bin/tinymix -D ${main_sound_card} 'SLIM TX7 MUX' 'ZERO' > /dev/null 2>&1
		/system/bin/tinymix -D ${main_sound_card} 'ADC MUX7' 'AMIC' > /dev/null 2>&1
		/system/bin/tinymix -D ${main_sound_card} 'DMIC MUX7' 'ZERO' > /dev/null 2>&1
		/system/bin/tinymix -D ${main_sound_card} 'USB_DL_HL Switch' 0 > /dev/null 2>&1
		/system/bin/tinymix -D ${main_sound_card} 'USB_AUDIO_RX Port Mixer SLIM_0_TX' 0 > /dev/null 2>&1
    ;;
    "31")
		/system/bin/tinymix -D ${main_sound_card} 'AIF1_CAP Mixer SLIM TX7' 1 > /dev/null 2>&1
		/system/bin/tinymix -D ${main_sound_card} 'SLIM TX7 MUX' 'DEC7' > /dev/null 2>&1
		/system/bin/tinymix -D ${main_sound_card} 'ADC MUX7' 'DMIC' > /dev/null 2>&1
		/system/bin/tinymix -D ${main_sound_card} 'DMIC MUX7' 'DMIC4' > /dev/null 2>&1
		/system/bin/tinymix -D ${main_sound_card} 'USB_DL_HL Switch' 1 > /dev/null 2>&1
		/system/bin/tinymix -D ${main_sound_card} 'USB_AUDIO_RX Port Mixer SLIM_0_TX' 1 > /dev/null 2>&1
		/system/bin/tinyhostless -D ${main_sound_card}  -P 43 -C 5 -p 1024 -n 2 -c 1 -r 48000 -T 16 > /dev/null 2>&1 &
    ;;
    "30")
		killall -SIGINT tinyhostless > /dev/null 2>&1
		/system/bin/tinymix -D ${main_sound_card} 'AIF1_CAP Mixer SLIM TX7' 0 > /dev/null 2>&1
		/system/bin/tinymix -D ${main_sound_card} 'SLIM TX7 MUX' 'ZERO' > /dev/null 2>&1
		/system/bin/tinymix -D ${main_sound_card} 'ADC MUX7' 'AMIC' > /dev/null 2>&1
		/system/bin/tinymix -D ${main_sound_card} 'DMIC MUX7' 'ZERO' > /dev/null 2>&1
		/system/bin/tinymix -D ${main_sound_card} 'USB_DL_HL Switch' 0 > /dev/null 2>&1
		/system/bin/tinymix -D ${main_sound_card} 'USB_AUDIO_RX Port Mixer SLIM_0_TX' 0 > /dev/null 2>&1
    ;;
    "51")
		/system/bin/tinymix -D ${main_sound_card} 'USB_AUDIO_TX Channels' 'Two' > /dev/null 2>&1
		/system/bin/tinymix -D ${main_sound_card} 'USB_DL_HL Switch' 1 > /dev/null 2>&1
		/system/bin/tinymix -D ${main_sound_card} 'USB_AUDIO_RX Port Mixer USB_AUDIO_TX' 1 > /dev/null 2>&1
		/system/bin/tinyhostless -D ${main_sound_card}  -P 43 -C 43 -p 1024 -n 2 -c 1 -r 48000 -T 16 > /dev/null 2>&1 &
		;;
    "50")
		killall -SIGINT tinyhostless > /dev/null 2>&1
		/system/bin/tinymix -D ${main_sound_card} 'USB_DL_HL Switch' 0 > /dev/null 2>&1
		/system/bin/tinymix -D ${main_sound_card} 'USB_AUDIO_RX Port Mixer USB_AUDIO_TX' 0 > /dev/null 2>&1
    ;;
    *)

    ;; #Do nothing
esac
