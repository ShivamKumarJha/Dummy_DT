# fihtdc, DanielYJHsieh, 20141205, add for FQC audio loopback
# For FQC audio loopback

fqcaudio=`getprop debug.sys.fqcaudio`
case "$fqcaudio" in
    "11")
		tinymix 'AIF1_CAP Mixer SLIM TX7' 1
		tinymix 'SLIM TX7 MUX' 'DEC7'
		tinymix 'ADC MUX7' 'DMIC'
		tinymix 'DMIC MUX7' 'DMIC0'
		tinymix 'DEC7 Volume' 96
		tinymix 'USB_AUDIO_RX dev_token' 65536
		tinymix 'USB_DL_HL Switch' 1
		tinymix 'USB_AUDIO_RX Port Mixer SLIM_0_TX' 1
		tinyhostless -D 0 -P 43 -C 5 -p 1024 -n 2 -c 1 -r 48000
    ;;
    "10")
		tinymix 'AIF1_CAP Mixer SLIM TX7' 0
		tinymix 'SLIM TX7 MUX' 'ZERO'
		tinymix 'ADC MUX7' 'AMIC'
		tinymix 'DMIC MUX7' 'ZERO'
		tinymix 'DEC7 Volume' 0
		tinymix 'USB_DL_HL Switch' 0
		tinymix 'USB_AUDIO_RX Port Mixer SLIM_0_TX' 0
		killall -SIGINT tinyhostless
    ;;
    "21")
		tinymix 'AIF1_CAP Mixer SLIM TX7' 1
		tinymix 'SLIM TX7 MUX' 'DEC7'
		tinymix 'ADC MUX7' 'DMIC'
		tinymix 'DMIC MUX7' 'DMIC3'
		tinymix 'DEC7 Volume' 96
		tinymix 'USB_AUDIO_RX dev_token' 65536
		tinymix 'USB_DL_HL Switch' 1
		tinymix 'USB_AUDIO_RX Port Mixer SLIM_0_TX' 1
		tinyhostless -D 0 -P 43 -C 5 -p 1024 -n 2 -c 1 -r 48000
    ;;
    "20")
		tinymix 'AIF1_CAP Mixer SLIM TX7' 0
		tinymix 'SLIM TX7 MUX' 'ZERO'
		tinymix 'ADC MUX7' 'AMIC'
		tinymix 'DMIC MUX7' 'ZERO'
		tinymix 'DEC7 Volume' 0
		tinymix 'USB_DL_HL Switch' 0
		tinymix 'USB_AUDIO_RX Port Mixer SLIM_0_TX' 0
		killall -SIGINT tinyhostless
    ;;
    *)
		setprop debug.sys.fqcaudio 0
    ;; #Do nothing
esac
