# For FQC audio loopback

fqcaudio=`getprop debug.sys.fqcaudio`
main_sound_card=`cat /proc/asound/cards |grep "sdm845tavil"|sed 's/ /\t/g'|cut -f 2`
if [ "$main_sound_card" = "1" ];then
	tinymix -D ${main_sound_card} 'USB_AUDIO_RX dev_token' 0 > /dev/null 2>&1
	tinymix -D ${main_sound_card} 'USB_AUDIO_TX dev_token' 1 > /dev/null 2>&1
else
	tinymix -D ${main_sound_card} 'USB_AUDIO_RX dev_token' 65536 > /dev/null 2>&1
	tinymix -D ${main_sound_card} 'USB_AUDIO_TX dev_token' 65537 > /dev/null 2>&1
fi
case "$fqcaudio" in
    "11")
		tinymix -D ${main_sound_card} 'AIF1_CAP Mixer SLIM TX7' 1 > /dev/null 2>&1
		tinymix -D ${main_sound_card} 'CDC_IF TX7 MUX' 'DEC7' > /dev/null 2>&1
		tinymix -D ${main_sound_card} 'ADC MUX7' 'DMIC' > /dev/null 2>&1
		tinymix -D ${main_sound_card} 'DMIC MUX7' 'DMIC1' > /dev/null 2>&1
		tinymix -D ${main_sound_card} 'DEC7 Volume' 96 > /dev/null 2>&1
		tinymix -D ${main_sound_card} 'USB_DL_HL Switch' 1 > /dev/null 2>&1
		tinymix -D ${main_sound_card} 'USB_AUDIO_RX Port Mixer SLIM_0_TX' 1 > /dev/null 2>&1
		tinyhostless -D ${main_sound_card} -P 39 -C 5 -p 1024 -n 2 -c 1 -r 48000 > /dev/null 2>&1 &
    ;;
    "10")
		killall -SIGINT tinyhostless > /dev/null 2>&1
		tinymix -D ${main_sound_card} 'AIF1_CAP Mixer SLIM TX7' 0 > /dev/null 2>&1
		tinymix -D ${main_sound_card} 'CDC_IF TX7 MUX' 'ZERO' > /dev/null 2>&1
		tinymix -D ${main_sound_card} 'ADC MUX7' 'AMIC' > /dev/null 2>&1
		tinymix -D ${main_sound_card} 'DMIC MUX7' 'ZERO' > /dev/null 2>&1
		tinymix -D ${main_sound_card} 'DEC7 Volume' 0 > /dev/null 2>&1
		tinymix -D ${main_sound_card} 'USB_DL_HL Switch' 0 > /dev/null 2>&1
		tinymix -D ${main_sound_card} 'USB_AUDIO_RX Port Mixer SLIM_0_TX' 0 > /dev/null 2>&1 &
    ;;
    "21")
		tinymix -D ${main_sound_card} 'AIF1_CAP Mixer SLIM TX7' 1 > /dev/null 2>&1
		tinymix -D ${main_sound_card} 'CDC_IF TX7 MUX' 'DEC7' > /dev/null 2>&1
		tinymix -D ${main_sound_card} 'ADC MUX7' 'DMIC' > /dev/null 2>&1
		tinymix -D ${main_sound_card} 'DMIC MUX7' 'DMIC3' > /dev/null 2>&1
		tinymix -D ${main_sound_card} 'DEC7 Volume' 96 > /dev/null 2>&1
		tinymix -D ${main_sound_card} 'USB_DL_HL Switch' 1 > /dev/null 2>&1
		tinymix -D ${main_sound_card} 'USB_AUDIO_RX Port Mixer SLIM_0_TX' 1 > /dev/null 2>&1
		tinyhostless -D ${main_sound_card} -P 39 -C 5 -p 1024 -n 2 -c 1 -r 48000 > /dev/null 2>&1 &
    ;;
    "20")
		killall -SIGINT tinyhostless > /dev/null 2>&1
		tinymix -D ${main_sound_card} 'AIF1_CAP Mixer SLIM TX7' 0 > /dev/null 2>&1
		tinymix -D ${main_sound_card} 'CDC_IF TX7 MUX' 'ZERO' > /dev/null 2>&1
		tinymix -D ${main_sound_card} 'ADC MUX7' 'AMIC' > /dev/null 2>&1
		tinymix -D ${main_sound_card} 'DMIC MUX7' 'ZERO' > /dev/null 2>&1
		tinymix -D ${main_sound_card} 'DEC7 Volume' 0 > /dev/null 2>&1
		tinymix -D ${main_sound_card} 'USB_DL_HL Switch' 0 > /dev/null 2>&1
		tinymix -D ${main_sound_card} 'USB_AUDIO_RX Port Mixer SLIM_0_TX' 0 > /dev/null 2>&1
    ;;
    "31")
		tinymix -D ${main_sound_card} 'AIF1_CAP Mixer SLIM TX7' 1 > /dev/null 2>&1
		tinymix -D ${main_sound_card} 'CDC_IF TX7 MUX' 'DEC7' > /dev/null 2>&1
		tinymix -D ${main_sound_card} 'ADC MUX7' 'DMIC' > /dev/null 2>&1
		tinymix -D ${main_sound_card} 'DMIC MUX7' 'DMIC5' > /dev/null 2>&1
		tinymix -D ${main_sound_card} 'DEC7 Volume' 96 > /dev/null 2>&1
		tinymix -D ${main_sound_card} 'USB_DL_HL Switch' 1 > /dev/null 2>&1
		tinymix -D ${main_sound_card} 'USB_AUDIO_RX Port Mixer SLIM_0_TX' 1 > /dev/null 2>&1
		tinyhostless -D ${main_sound_card} -P 39 -C 5 -p 1024 -n 2 -c 1 -r 48000 > /dev/null 2>&1 &
    ;;
    "30")
		killall -SIGINT tinyhostless > /dev/null 2>&1
		tinymix -D ${main_sound_card} 'AIF1_CAP Mixer SLIM TX7' 0 > /dev/null 2>&1
		tinymix -D ${main_sound_card} 'CDC_IF TX7 MUX' 'ZERO' > /dev/null 2>&1
		tinymix -D ${main_sound_card} 'ADC MUX7' 'AMIC' > /dev/null 2>&1
		tinymix -D ${main_sound_card} 'DMIC MUX7' 'ZERO' > /dev/null 2>&1
		tinymix -D ${main_sound_card} 'DEC7 Volume' 0 > /dev/null 2>&1
		tinymix -D ${main_sound_card} 'USB_DL_HL Switch' 0 > /dev/null 2>&1
		tinymix -D ${main_sound_card} 'USB_AUDIO_RX Port Mixer SLIM_0_TX' 0 > /dev/null 2>&1
    ;;
    *)
		setprop debug.sys.fqcaudio 0
    ;; #Do nothing
esac
