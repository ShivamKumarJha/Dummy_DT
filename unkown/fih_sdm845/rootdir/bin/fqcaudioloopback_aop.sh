#!/vendor/bin/sh

fqcaudio=`/vendor/bin/getprop vendor.sys.fqcaudio`
case "$fqcaudio" in
    "11")   # mic 1 to (digital) headset recv loopback test start
		/system/bin/tinymix 'DMIC SampleRate' 'KHZ_600' > /dev/null 2>&1
		/system/bin/tinymix 'USB_AUDIO_RX dev_token' 65536 > /dev/null 2>&1
		/system/bin/tinymix 'AIF1_CAP Mixer SLIM TX7' 1 > /dev/null 2>&1
		/system/bin/tinymix 'SLIM_0_TX Channels' 'One' > /dev/null 2>&1
		/system/bin/tinymix 'CDC_IF TX7 MUX' 'DEC7' > /dev/null 2>&1
		/system/bin/tinymix 'ADC MUX7' 'DMIC' > /dev/null 2>&1
		/system/bin/tinymix 'DMIC MUX7' 'DMIC1' > /dev/null 2>&1
		/system/bin/tinymix 'USB_AUDIO_RX SampleRate' 'KHZ_48' > /dev/null 2>&1
		/system/bin/tinymix 'USB_AUDIO_RX Channels' 'Two' > /dev/null 2>&1
		/system/bin/tinymix 'USB_AUDIO_RX Format' 'S16_LE' > /dev/null 2>&1
		/system/bin/tinymix 'USB_DL_HL Switch' 1 > /dev/null 2>&1
		/system/bin/tinymix 'USB_AUDIO_RX Port Mixer SLIM_0_TX' 1 > /dev/null 2>&1
		/system/bin/tinyhostless -D 0 -P 39 -C 5 -p 1024 -n 2 -c 1 -r 48000 -T 16 > /dev/null 2>&1 &
		;;
    "10")   # mic 1 to (digital) headset recv loopback test end
		killall -9 tinyhostless > /dev/null 2>&1
		/system/bin/tinymix 'DMIC SampleRate' 'DEFAULT' > /dev/null 2>&1
		/system/bin/tinymix 'USB_AUDIO_RX dev_token' 0 > /dev/null 2>&1
		/system/bin/tinymix 'AIF1_CAP Mixer SLIM TX7' 0 > /dev/null 2>&1
		/system/bin/tinymix 'CDC_IF TX7 MUX' 'ZERO' > /dev/null 2>&1
		/system/bin/tinymix 'ADC MUX7' 'AMIC' > /dev/null 2>&1
		/system/bin/tinymix 'DMIC MUX7' 'ZERO' > /dev/null 2>&1
		/system/bin/tinymix 'USB_DL_HL Switch' 0 > /dev/null 2>&1
		/system/bin/tinymix 'USB_AUDIO_RX Port Mixer SLIM_0_TX' 0 > /dev/null 2>&1
		;;
    "21")   # mic 2 to (digital) headset recv loopback test start
		/system/bin/tinymix 'DMIC SampleRate' 'KHZ_600' > /dev/null 2>&1
		/system/bin/tinymix 'USB_AUDIO_RX dev_token' 65536 > /dev/null 2>&1
		/system/bin/tinymix 'AIF1_CAP Mixer SLIM TX7' 1 > /dev/null 2>&1
		/system/bin/tinymix 'SLIM_0_TX Channels' 'One' > /dev/null 2>&1
		/system/bin/tinymix 'CDC_IF TX7 MUX' 'DEC7' > /dev/null 2>&1
		/system/bin/tinymix 'ADC MUX7' 'DMIC' > /dev/null 2>&1
		/system/bin/tinymix 'DMIC MUX7' 'DMIC3' > /dev/null 2>&1
		/system/bin/tinymix 'USB_AUDIO_RX SampleRate' 'KHZ_48' > /dev/null 2>&1
		/system/bin/tinymix 'USB_AUDIO_RX Channels' 'Two' > /dev/null 2>&1
		/system/bin/tinymix 'USB_AUDIO_RX Format' 'S16_LE' > /dev/null 2>&1
		/system/bin/tinymix 'USB_DL_HL Switch' 1 > /dev/null 2>&1
		/system/bin/tinymix 'USB_AUDIO_RX Port Mixer SLIM_0_TX' 1 > /dev/null 2>&1
		/system/bin/tinyhostless -D 0 -P 39 -C 5 -p 1024 -n 2 -c 1 -r 48000 -T 16 > /dev/null 2>&1 &
		;;
    "20")   # mic 2 to (digital) headset recv loopback test end
		killall -9 tinyhostless > /dev/null 2>&1
		/system/bin/tinymix 'DMIC SampleRate' 'DEFAULT' > /dev/null 2>&1
		/system/bin/tinymix 'USB_AUDIO_RX dev_token' 0 > /dev/null 2>&1
		/system/bin/tinymix 'AIF1_CAP Mixer SLIM TX7' 0 > /dev/null 2>&1
		/system/bin/tinymix 'CDC_IF TX7 MUX' 'ZERO' > /dev/null 2>&1
		/system/bin/tinymix 'ADC MUX7' 'AMIC' > /dev/null 2>&1
		/system/bin/tinymix 'DMIC MUX7' 'ZERO' > /dev/null 2>&1
		/system/bin/tinymix 'USB_DL_HL Switch' 0 > /dev/null 2>&1
		/system/bin/tinymix 'USB_AUDIO_RX Port Mixer SLIM_0_TX' 0 > /dev/null 2>&1
		;;
    "31")   # mic 3 to (digital) headset recv loopback test start
		/system/bin/tinymix 'DMIC SampleRate' 'KHZ_600' > /dev/null 2>&1
		/system/bin/tinymix 'USB_AUDIO_RX dev_token' 65536 > /dev/null 2>&1
		/system/bin/tinymix 'AIF1_CAP Mixer SLIM TX7' 1 > /dev/null 2>&1
		/system/bin/tinymix 'SLIM_0_TX Channels' 'One' > /dev/null 2>&1
		/system/bin/tinymix 'CDC_IF TX7 MUX' 'DEC7' > /dev/null 2>&1
		/system/bin/tinymix 'ADC MUX7' 'DMIC' > /dev/null 2>&1
		/system/bin/tinymix 'DMIC MUX7' 'DMIC5' > /dev/null 2>&1
		/system/bin/tinymix 'USB_AUDIO_RX SampleRate' 'KHZ_48' > /dev/null 2>&1
		/system/bin/tinymix 'USB_AUDIO_RX Channels' 'Two' > /dev/null 2>&1
		/system/bin/tinymix 'USB_AUDIO_RX Format' 'S16_LE' > /dev/null 2>&1
		/system/bin/tinymix 'USB_DL_HL Switch' 1 > /dev/null 2>&1
		/system/bin/tinymix 'USB_AUDIO_RX Port Mixer SLIM_0_TX' 1 > /dev/null 2>&1
		/system/bin/tinyhostless -D 0 -P 39 -C 5 -p 1024 -n 2 -c 1 -r 48000 -T 16 > /dev/null 2>&1 &
		;;
    "30")   # mic 3 to (digital) headset recv loopback test end
		killall -9 tinyhostless > /dev/null 2>&1
		/system/bin/tinymix 'DMIC SampleRate' 'DEFAULT' > /dev/null 2>&1
		/system/bin/tinymix 'USB_AUDIO_RX dev_token' 0 > /dev/null 2>&1
		/system/bin/tinymix 'AIF1_CAP Mixer SLIM TX7' 0 > /dev/null 2>&1
		/system/bin/tinymix 'CDC_IF TX7 MUX' 'ZERO' > /dev/null 2>&1
		/system/bin/tinymix 'ADC MUX7' 'AMIC' > /dev/null 2>&1
		/system/bin/tinymix 'DMIC MUX7' 'ZERO' > /dev/null 2>&1
		/system/bin/tinymix 'USB_DL_HL Switch' 0 > /dev/null 2>&1
		/system/bin/tinymix 'USB_AUDIO_RX Port Mixer SLIM_0_TX' 0 > /dev/null 2>&1
		;;
    "41")   # (digital) headset mic to headset recv loopback test start
		/system/bin/tinymix 'USB_AUDIO_RX dev_token' 65536 > /dev/null 2>&1
		/system/bin/tinymix 'USB_AUDIO_RX SampleRate' 'KHZ_48' > /dev/null 2>&1
		/system/bin/tinymix 'USB_AUDIO_RX Channels' 'Two' > /dev/null 2>&1
		/system/bin/tinymix 'USB_AUDIO_RX Format' 'S16_LE' > /dev/null 2>&1
		/system/bin/tinymix 'USB_AUDIO_TX dev_token' 65537 > /dev/null 2>&1
		/system/bin/tinymix 'USB_AUDIO_TX SampleRate' 'KHZ_48' > /dev/null 2>&1
		/system/bin/tinymix 'USB_AUDIO_TX Channels' 'Two' > /dev/null 2>&1
		/system/bin/tinymix 'USB_AUDIO_TX Format' 'S16_LE' > /dev/null 2>&1
		/system/bin/tinymix 'USB_DL_HL Switch' 1 > /dev/null 2>&1
		/system/bin/tinymix 'USB_AUDIO_RX Port Mixer USB_AUDIO_TX' 1 > /dev/null 2>&1
		/system/bin/tinyhostless -D 0 -P 39 -C 39 -p 1024 -n 2 -c 1 -r 48000 -T 16 > /dev/null 2>&1 &
		;;
    "40")   # (digital) headset mic to headset recv loopback test end
		killall -9 tinyhostless > /dev/null 2>&1
		/system/bin/tinymix 'DMIC SampleRate' 'DEFAULT' > /dev/null 2>&1
		/system/bin/tinymix 'USB_AUDIO_RX dev_token' 0 > /dev/null 2>&1
		/system/bin/tinymix 'USB_AUDIO_RX Channels' 'One' > /dev/null 2>&1
		/system/bin/tinymix 'USB_AUDIO_TX dev_token' 0 > /dev/null 2>&1
		/system/bin/tinymix 'USB_AUDIO_TX Channels' 'One' > /dev/null 2>&1
		/system/bin/tinymix 'USB_DL_HL Switch' 0 > /dev/null 2>&1
		/system/bin/tinymix 'USB_AUDIO_RX Port Mixer USB_AUDIO_TX' 0 > /dev/null 2>&1
		;;
    "51")   # mic 1 to (analog) headset recv loopback test start
		/system/bin/tinymix 'DMIC SampleRate' 'KHZ_600' > /dev/null 2>&1
		/system/bin/tinymix 'ADC MUX0' 'DMIC' > /dev/null 2>&1
		/system/bin/tinymix 'DMIC MUX0' 'DMIC1' > /dev/null 2>&1
		/system/bin/tinymix 'IIR0 INP0 MUX' 'DEC0' > /dev/null 2>&1
		/system/bin/tinymix 'RX INT1_1 MIX1 INP0' 'IIR0' > /dev/null 2>&1
		/system/bin/tinymix 'RX INT2_1 MIX1 INP0' 'IIR0' > /dev/null 2>&1
		/system/bin/tinymix 'RX INT1 DEM MUX' 'CLSH_DSM_OUT' > /dev/null 2>&1
		/system/bin/tinymix 'RX INT2 DEM MUX' 'CLSH_DSM_OUT' > /dev/null 2>&1
		;;
    "50")   # mic 1 to (analog) headset recv loopback test end
		/system/bin/tinymix 'DMIC SampleRate' 'DEFAULT' > /dev/null 2>&1
		/system/bin/tinymix 'ADC MUX0' 'AMIC' > /dev/null 2>&1
		/system/bin/tinymix 'DMIC MUX0' 'ZERO' > /dev/null 2>&1
		/system/bin/tinymix 'IIR0 INP0 MUX' 'ZERO' > /dev/null 2>&1
		/system/bin/tinymix 'RX INT1_1 MIX1 INP0' 'ZERO' > /dev/null 2>&1
		/system/bin/tinymix 'RX INT2_1 MIX1 INP0' 'ZERO' > /dev/null 2>&1
		;;
    "61")   # mic 2 to (analog) headset recv loopback test start
		/system/bin/tinymix 'DMIC SampleRate' 'KHZ_600' > /dev/null 2>&1
		/system/bin/tinymix 'ADC MUX0' 'DMIC' > /dev/null 2>&1
		/system/bin/tinymix 'DMIC MUX0' 'DMIC3' > /dev/null 2>&1
		/system/bin/tinymix 'IIR0 INP0 MUX' 'DEC0' > /dev/null 2>&1
		/system/bin/tinymix 'RX INT1_1 MIX1 INP0' 'IIR0' > /dev/null 2>&1
		/system/bin/tinymix 'RX INT2_1 MIX1 INP0' 'IIR0' > /dev/null 2>&1
		/system/bin/tinymix 'RX INT1 DEM MUX' 'CLSH_DSM_OUT' > /dev/null 2>&1
		/system/bin/tinymix 'RX INT2 DEM MUX' 'CLSH_DSM_OUT' > /dev/null 2>&1
		;;
    "60")   # mic 2 to (analog) headset recv loopback test end
		/system/bin/tinymix 'DMIC SampleRate' 'DEFAULT' > /dev/null 2>&1
		/system/bin/tinymix 'ADC MUX0' 'AMIC' > /dev/null 2>&1
		/system/bin/tinymix 'DMIC MUX0' 'ZERO' > /dev/null 2>&1
		/system/bin/tinymix 'IIR0 INP0 MUX' 'ZERO' > /dev/null 2>&1
		/system/bin/tinymix 'RX INT1_1 MIX1 INP0' 'ZERO' > /dev/null 2>&1
		/system/bin/tinymix 'RX INT2_1 MIX1 INP0' 'ZERO' > /dev/null 2>&1
		;;
    "71")   # mic 3 to (analog) headset recv loopback test start
		/system/bin/tinymix 'DMIC SampleRate' 'KHZ_600' > /dev/null 2>&1
		/system/bin/tinymix 'ADC MUX0' 'DMIC' > /dev/null 2>&1
		/system/bin/tinymix 'DMIC MUX0' 'DMIC5' > /dev/null 2>&1
		/system/bin/tinymix 'IIR0 INP0 MUX' 'DEC0' > /dev/null 2>&1
		/system/bin/tinymix 'RX INT1_1 MIX1 INP0' 'IIR0' > /dev/null 2>&1
		/system/bin/tinymix 'RX INT2_1 MIX1 INP0' 'IIR0' > /dev/null 2>&1
		/system/bin/tinymix 'RX INT1 DEM MUX' 'CLSH_DSM_OUT' > /dev/null 2>&1
		/system/bin/tinymix 'RX INT2 DEM MUX' 'CLSH_DSM_OUT' > /dev/null 2>&1
		;;
    "70")   # mic 3 to (analog) headset recv loopback test end
		/system/bin/tinymix 'DMIC SampleRate' 'DEFAULT' > /dev/null 2>&1
		/system/bin/tinymix 'ADC MUX0' 'AMIC' > /dev/null 2>&1
		/system/bin/tinymix 'DMIC MUX0' 'ZERO' > /dev/null 2>&1
		/system/bin/tinymix 'IIR0 INP0 MUX' 'ZERO' > /dev/null 2>&1
		/system/bin/tinymix 'RX INT1_1 MIX1 INP0' 'ZERO' > /dev/null 2>&1
		/system/bin/tinymix 'RX INT2_1 MIX1 INP0' 'ZERO' > /dev/null 2>&1
		;;
    "81")   # (analog) headset mic to headset recv loopback test start
		/system/bin/tinymix 'ADC MUX0' 'AMIC' > /dev/null 2>&1
		/system/bin/tinymix 'AMIC MUX0' 'ADC2' > /dev/null 2>&1
		/system/bin/tinymix 'IIR0 INP0 MUX' 'DEC0' > /dev/null 2>&1
		/system/bin/tinymix 'RX INT1_1 MIX1 INP1' 'IIR0' > /dev/null 2>&1
		/system/bin/tinymix 'RX INT2_1 MIX1 INP1' 'IIR0' > /dev/null 2>&1
		/system/bin/tinymix 'RX INT1 DEM MUX' 'CLSH_DSM_OUT' > /dev/null 2>&1
		/system/bin/tinymix 'RX INT2 DEM MUX' 'CLSH_DSM_OUT' > /dev/null 2>&1
		;;
    "80")   # (analog) headset mic to headset recv loopback test end
		/system/bin/tinymix 'AMIC MUX0' 'ZERO' > /dev/null 2>&1
		/system/bin/tinymix 'IIR0 INP0 MUX' 'ZERO' > /dev/null 2>&1
		/system/bin/tinymix 'RX INT1_1 MIX1 INP1' 'ZERO' > /dev/null 2>&1
		/system/bin/tinymix 'RX INT2_1 MIX1 INP1' 'ZERO' > /dev/null 2>&1
		;;
    *)
		;; #Do nothing
esac
