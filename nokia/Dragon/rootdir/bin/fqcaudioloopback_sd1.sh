#!/system/bin/sh

fqcaudio=`/vendor/bin/getprop vendor.sys.fqcaudio`
case "$fqcaudio" in
	"11")	# mic 1 to (digital) headset recv loopback test start
		/system/bin/tinymix 'DEC1 MUX' 'ADC1' > /dev/null 2>&1
		/system/bin/tinymix 'ADC1_INP1 Switch' 1 > /dev/null 2>&1
		/system/bin/tinymix 'USB_AUDIO_RX dev_token' 65536 > /dev/null 2>&1
		/system/bin/tinymix 'USB_DL_HL Switch' 1 > /dev/null 2>&1
		/system/bin/tinymix 'USB_AUDIO_RX Port Mixer INT3_MI2S_TX' 1 > /dev/null 2>&1
		/system/bin/tinyhostless -D 0 -P 67 -C 11 -p 1024 -n 2 -c 1 -r 48000 -T 16 > /dev/null 2>&1 &
		;;
	"10")	# mic 1 to (digital) headset recv loopback test end
		/system/bin/tinymix 'DEC1 MUX' 'ZERO' > /dev/null 2>&1
		/system/bin/tinymix 'ADC1_INP1 Switch' 0 > /dev/null 2>&1
		/system/bin/tinymix 'USB_DL_HL Switch' 0 > /dev/null 2>&1
		/system/bin/tinymix 'USB_AUDIO_RX Port Mixer INT3_MI2S_TX' 0 > /dev/null 2>&1
		/vendor/bin/killall -9 /system/bin/tinyhostless > /dev/null 2>&1
		;;
	"21")	# mic 2 to (digital) headset recv loopback test start
		/system/bin/tinymix 'DEC1 MUX' 'ADC2' > /dev/null 2>&1
		/system/bin/tinymix 'ADC2 MUX' 'INP3' > /dev/null 2>&1
		/system/bin/tinymix 'USB_AUDIO_RX dev_token' 65536 > /dev/null 2>&1
		/system/bin/tinymix 'USB_DL_HL Switch' 1 > /dev/null 2>&1
		/system/bin/tinymix 'USB_AUDIO_RX Port Mixer INT3_MI2S_TX' 1 > /dev/null 2>&1
		/system/bin/tinyhostless -D 0 -P 67 -C 11 -p 1024 -n 2 -c 1 -r 48000 -T 16 > /dev/null 2>&1 &
		;;
	"20")	# mic 2 to (digital) headset recv loopback test end
		/system/bin/tinymix 'DEC1 MUX' 'ZERO' > /dev/null 2>&1
		/system/bin/tinymix 'ADC2 MUX' 'ZERO' > /dev/null 2>&1
		/system/bin/tinymix 'USB_DL_HL Switch' 0 > /dev/null 2>&1
		/system/bin/tinymix 'USB_AUDIO_RX Port Mixer INT3_MI2S_TX' 0 > /dev/null 2>&1
		/vendor/bin/killall -9 /system/bin/tinyhostless > /dev/null 2>&1
		;;
	"31")	# (digital) headset mic to headset recv loopback test start
		/system/bin/tinymix 'USB_AUDIO_RX dev_token' 65536 > /dev/null 2>&1
		/system/bin/tinymix 'USB_AUDIO_TX dev_token' 65537 > /dev/null 2>&1
		/system/bin/tinymix 'USB_AUDIO_TX Channels' 'Two' > /dev/null 2>&1
		/system/bin/tinymix 'USB_DL_HL Switch' 1 > /dev/null 2>&1
		/system/bin/tinymix 'USB_AUDIO_RX Port Mixer USB_AUDIO_TX' 1 > /dev/null 2>&1
		/system/bin/tinyhostless -D 0 -P 67 -C 67 -p 1024 -n 2 -c 1 -r 48000 -T 16 > /dev/null 2>&1 &
		;;
	"30")	# (digital) headset mic to headset recv loopback test end
		/system/bin/tinymix 'USB_AUDIO_TX Channels' 'One' > /dev/null 2>&1
		/system/bin/tinymix 'USB_DL_HL Switch' 0 > /dev/null 2>&1
		/system/bin/tinymix 'USB_AUDIO_RX Port Mixer USB_AUDIO_TX' 0 > /dev/null 2>&1
		/vendor/bin/killall -9 /system/bin/tinyhostless > /dev/null 2>&1
		;;
	"41")	# mic 1 to (analog) headset recv loopback test start
		/system/bin/tinymix 'LOOPBACK Mode' 'ENABLE' > /dev/null 2>&1
		/system/bin/tinymix 'DEC1 MUX' 'ADC1' > /dev/null 2>&1
		/system/bin/tinymix 'ADC1_INP1 Switch' 1 > /dev/null 2>&1
		/system/bin/tinymix 'IIR1 INP1 MUX' 'DEC1' > /dev/null 2>&1
		/system/bin/tinymix 'RX1 MIX1 INP1' 'IIR1' > /dev/null 2>&1
		/system/bin/tinymix 'RX2 MIX1 INP1' 'IIR1' > /dev/null 2>&1
		/system/bin/tinymix 'RDAC2 MUX' 'RX2' > /dev/null 2>&1
		/system/bin/tinymix 'HPHL' 'Switch' > /dev/null 2>&1
		/system/bin/tinymix 'HPHR' 'Switch' > /dev/null 2>&1
		/system/bin/tinymix 'Loopback MCLK' 'ENABLE' > /dev/null 2>&1
		;;
	"40")	# mic 1 to (analog) headset recv loopback test end
		/system/bin/tinymix 'LOOPBACK Mode' 'DISABLE' > /dev/null 2>&1
		/system/bin/tinymix 'DEC1 MUX' 'ZERO' > /dev/null 2>&1
		/system/bin/tinymix 'ADC1_INP1 Switch' 0 > /dev/null 2>&1
		/system/bin/tinymix 'IIR1 INP1 MUX' 'ZERO' > /dev/null 2>&1
		/system/bin/tinymix 'RX1 MIX1 INP1' 'ZERO' > /dev/null 2>&1
		/system/bin/tinymix 'RX2 MIX1 INP1' 'ZERO' > /dev/null 2>&1
		/system/bin/tinymix 'RDAC2 MUX' 'ZERO' > /dev/null 2>&1
		/system/bin/tinymix 'HPHL' 'ZERO' > /dev/null 2>&1
		/system/bin/tinymix 'HPHR' 'ZERO' > /dev/null 2>&1
		/system/bin/tinymix 'Loopback MCLK' 'DISABLE' > /dev/null 2>&1
		;;
	"51")	# mic 2 to (analog) headset recv loopback test start
		/system/bin/tinymix 'LOOPBACK Mode' 'ENABLE' > /dev/null 2>&1
		/system/bin/tinymix 'DEC1 MUX' 'ADC2' > /dev/null 2>&1
		/system/bin/tinymix 'ADC2 MUX' 'INP3' > /dev/null 2>&1
		/system/bin/tinymix 'IIR1 INP1 MUX' 'DEC1' > /dev/null 2>&1
		/system/bin/tinymix 'RX1 MIX1 INP1' 'IIR1' > /dev/null 2>&1
		/system/bin/tinymix 'RX2 MIX1 INP1' 'IIR1' > /dev/null 2>&1
		/system/bin/tinymix 'RDAC2 MUX' 'RX2' > /dev/null 2>&1
		/system/bin/tinymix 'HPHL' 'Switch' > /dev/null 2>&1
		/system/bin/tinymix 'HPHR' 'Switch' > /dev/null 2>&1
		/system/bin/tinymix 'Loopback MCLK' 'ENABLE' > /dev/null 2>&1
		;;
	"50")	# mic 2 to (analog) headset recv loopback test end
		/system/bin/tinymix 'LOOPBACK Mode' 'DISABLE' > /dev/null 2>&1
		/system/bin/tinymix 'DEC1 MUX' 'ZERO' > /dev/null 2>&1
		/system/bin/tinymix 'ADC2 MUX' 'ZERO' > /dev/null 2>&1
		/system/bin/tinymix 'IIR1 INP1 MUX' 'ZERO' > /dev/null 2>&1
		/system/bin/tinymix 'RX1 MIX1 INP1' 'ZERO' > /dev/null 2>&1
		/system/bin/tinymix 'RX2 MIX1 INP1' 'ZERO' > /dev/null 2>&1
		/system/bin/tinymix 'RDAC2 MUX' 'ZERO' > /dev/null 2>&1
		/system/bin/tinymix 'HPHL' 'ZERO' > /dev/null 2>&1
		/system/bin/tinymix 'HPHR' 'ZERO' > /dev/null 2>&1
		/system/bin/tinymix 'Loopback MCLK' 'DISABLE' > /dev/null 2>&1
		;;
	"61")	# (analog) headset mic to headset recv loopback test start
		/system/bin/tinymix 'LOOPBACK Mode' 'ENABLE' > /dev/null 2>&1
		/system/bin/tinymix 'DEC1 MUX' 'ADC2' > /dev/null 2>&1
		/system/bin/tinymix 'ADC2 MUX' 'INP2' > /dev/null 2>&1
		/system/bin/tinymix 'IIR1 INP1 MUX' 'DEC1' > /dev/null 2>&1
		/system/bin/tinymix 'RX1 MIX1 INP1' 'IIR1' > /dev/null 2>&1
		/system/bin/tinymix 'RX2 MIX1 INP2' 'IIR1' > /dev/null 2>&1
		/system/bin/tinymix 'RDAC2 MUX' 'RX2' > /dev/null 2>&1
		/system/bin/tinymix 'HPHL' 'Switch' > /dev/null 2>&1
		/system/bin/tinymix 'HPHR' 'Switch' > /dev/null 2>&1
		/system/bin/tinymix 'Loopback MCLK' 'ENABLE' > /dev/null 2>&1
		;;
	"60")	# (analog) headset mic to headset recv loopback test end
		/system/bin/tinymix 'LOOPBACK Mode' 'DISABLE' > /dev/null 2>&1
		/system/bin/tinymix 'DEC1 MUX' 'ZERO' > /dev/null 2>&1
		/system/bin/tinymix 'ADC2 MUX' 'ZERO' > /dev/null 2>&1
		/system/bin/tinymix 'IIR1 INP1 MUX' 'ZERO' > /dev/null 2>&1
		/system/bin/tinymix 'RX1 MIX1 INP1' 'ZERO' > /dev/null 2>&1
		/system/bin/tinymix 'RX2 MIX1 INP2' 'ZERO' > /dev/null 2>&1
		/system/bin/tinymix 'RDAC2 MUX' 'ZERO' > /dev/null 2>&1
		/system/bin/tinymix 'HPHL' 'ZERO' > /dev/null 2>&1
		/system/bin/tinymix 'HPHR' 'ZERO' > /dev/null 2>&1
		/system/bin/tinymix 'Loopback MCLK' 'DISABLE' > /dev/null 2>&1
		;;
	*)
		;; #Do nothing
esac
