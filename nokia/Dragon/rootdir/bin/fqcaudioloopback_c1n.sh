#!/vendor/bin/sh

fqcaudio=`/vendor/bin/getprop vendor.sys.fqcaudio`

soundcard=`cat /proc/asound/cards| cut -d " " -f 6`
case "$fqcaudio" in
	"11")
		#Do mic1 to headset
		/system/bin/tinymix 'LOOPBACK Mode' 'ENABLE' > /dev/null 2>&1
		if [ "$soundcard" != "sdm660-snd-card-c1n" ]; then
			/system/bin/tinymix 'DEC1 MUX' 'ADC1' > /dev/null 2>&1
			/system/bin/tinymix 'ADC1_INP1 Switch' '1' > /dev/null 2>&1
		else
			echo $soundcard
			/system/bin/tinymix 'DEC1 MUX' 'DMIC2' > /dev/null 2>&1
		fi
		/system/bin/tinymix 'IIR1 INP1 MUX' 'DEC1' > /dev/null 2>&1
		/system/bin/tinymix 'RX1 MIX1 INP1' 'IIR1' > /dev/null 2>&1
		/system/bin/tinymix 'RX2 MIX1 INP1' 'IIR1' > /dev/null 2>&1
		/system/bin/tinymix 'RDAC2 MUX' 'RX2' > /dev/null 2>&1
		/system/bin/tinymix 'HPHL' 'Switch' > /dev/null 2>&1
		/system/bin/tinymix 'HPHR' 'Switch' > /dev/null 2>&1
		/system/bin/tinymix 'Loopback MCLK' 'ENABLE' > /dev/null 2>&1
		;;
	"10")
		#stop mic1 to headset
		/system/bin/tinymix 'DEC1 MUX' 'ZERO' > /dev/null 2>&1
		if [ "$soundcard" != "sdm660-snd-card-c1n" ]; then
			/system/bin/tinymix 'ADC1_INP1 Switch' '0' > /dev/null 2>&1
		fi
		/system/bin/tinymix 'IIR1 INP1 MUX' 'ZERO' > /dev/null 2>&1
		/system/bin/tinymix 'RX1 MIX1 INP1' 'ZERO' > /dev/null 2>&1
		/system/bin/tinymix 'RX2 MIX1 INP1' 'ZERO' > /dev/null 2>&1
		/system/bin/tinymix 'RDAC2 MUX' 'ZERO' > /dev/null 2>&1
		/system/bin/tinymix 'HPHL' 'ZERO' > /dev/null 2>&1
		/system/bin/tinymix 'HPHR' 'ZERO' > /dev/null 2>&1
		/system/bin/tinymix 'Loopback MCLK' 'DISABLE' > /dev/null 2>&1
		/system/bin/tinymix 'LOOPBACK Mode' 'DISABLE' > /dev/null 2>&1
		;;
	"21")
		#Do mic2 to headset
		/system/bin/tinymix 'LOOPBACK Mode' 'ENABLE' > /dev/null 2>&1
		if [ "$soundcard" != "sdm660-snd-card-c1n" ]; then
			/system/bin/tinymix 'DEC1 MUX' 'ADC2' > /dev/null 2>&1
			/system/bin/tinymix 'ADC2 MUX' 'INP3' > /dev/null 2>&1
		else
			/system/bin/tinymix 'DEC1 MUX' 'DMIC4' > /dev/null 2>&1
		fi
		/system/bin/tinymix 'IIR1 INP1 MUX' 'DEC1' > /dev/null 2>&1
		/system/bin/tinymix 'RX1 MIX1 INP1' 'IIR1' > /dev/null 2>&1
		/system/bin/tinymix 'RX2 MIX1 INP1' 'IIR1' > /dev/null 2>&1
		/system/bin/tinymix 'RDAC2 MUX' 'RX2' > /dev/null 2>&1
		/system/bin/tinymix 'HPHL' 'Switch' > /dev/null 2>&1
		/system/bin/tinymix 'HPHR' 'Switch' > /dev/null 2>&1
		/system/bin/tinymix 'Loopback MCLK' 'ENABLE' > /dev/null 2>&1
		;;
	"20")
		#stop mic2 to headset
		/system/bin/tinymix 'DEC1 MUX' 'ZERO' > /dev/null 2>&1
		if [ "$soundcard" != "sdm660-snd-card-c1n" ]; then
			/system/bin/tinymix 'ADC2 MUX' 'ZERO' > /dev/null 2>&1
		fi
		/system/bin/tinymix 'IIR1 INP1 MUX' 'ZERO' > /dev/null 2>&1
		/system/bin/tinymix 'RX1 MIX1 INP1' 'ZERO' > /dev/null 2>&1
		/system/bin/tinymix 'RX2 MIX1 INP1' 'ZERO' > /dev/null 2>&1
		/system/bin/tinymix 'RDAC2 MUX' 'ZERO' > /dev/null 2>&1
		/system/bin/tinymix 'HPHL' 'ZERO' > /dev/null 2>&1
		/system/bin/tinymix 'HPHR' 'ZERO' > /dev/null 2>&1
		/system/bin/tinymix 'Loopback MCLK' 'DISABLE' > /dev/null 2>&1
		/system/bin/tinymix 'LOOPBACK Mode' 'DISABLE' > /dev/null 2>&1
		;;
	"31")
		#Do headset mic to headset
		/vendor/bin/tinymix2 'headsetmic-to-headset' 'ON' > /dev/null 2>&1
		;;
	"30")
		#stop headset mic to headset
		/vendor/bin/tinymix2 'headsetmic-to-headset' 'OFF' > /dev/null 2>&1
		;;
	*)
		;; #Do nothing
esac
