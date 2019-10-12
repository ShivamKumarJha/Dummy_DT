#!/vendor/bin/sh

fqcaudio=`/vendor/bin/getprop vendor.sys.fqcaudio`
case "$fqcaudio" in
	"11")
		#Do mic1 to headset
    /system/bin/tinymix 'LOOPBACK Mode' 'ENABLE' > /dev/null 2>&1
    /system/bin/tinymix 'DEC1 MUX' 'DMIC2' > /dev/null 2>&1
    /system/bin/tinymix 'IIR1 INP1 MUX' 'DEC1' > /dev/null 2>&1
    /system/bin/tinymix 'RX1 MIX1 INP1' 'IIR1' > /dev/null 2>&1
    /system/bin/tinymix 'RX2 MIX1 INP1' 'IIR1' > /dev/null 2>&1
    /system/bin/tinymix 'RDAC2 MUX' 'RX2' > /dev/null 2>&1
    /system/bin/tinymix 'HPHL' 'Switch' > /dev/null 2>&1
    /system/bin/tinymix 'HPHR' 'Switch' > /dev/null 2>&1
    /system/bin/tinymix 'IIR1 INP1 Volume' 84 > /dev/null 2>&1
    /system/bin/tinymix 'Loopback MCLK' 'ENABLE' > /dev/null 2>&1
		;;
	"10")
		#stop mic1 to headset
		/system/bin/tinymix 'DEC1 MUX' 'ZERO'  > /dev/null 2>&1
 		/system/bin/tinymix 'ADC2 MUX' 'ZERO'  > /dev/null 2>&1
		/system/bin/tinymix 'IIR1 INP1 MUX' 'ZERO'  > /dev/null 2>&1
		/system/bin/tinymix 'RX1 MIX1 INP1' 'ZERO'  > /dev/null 2>&1
		/system/bin/tinymix 'RX2 MIX1 INP1' 'ZERO'  > /dev/null 2>&1
		/system/bin/tinymix 'RDAC2 MUX' 'ZERO'  > /dev/null 2>&1
		/system/bin/tinymix 'HPHL' 'ZERO'  > /dev/null 2>&1
		/system/bin/tinymix 'HPHR' 'ZERO'  > /dev/null 2>&1
		/system/bin/tinymix 'Loopback MCLK' 'DISABLE' > /dev/null 2>&1
		/system/bin/tinymix 'LOOPBACK Mode' 'DISABLE' > /dev/null 2>&1
		/system/bin/tinymix 'IIR1 INP1 Volume' 309 > /dev/null 2>&1
		;;
	"21")
		#Do mic2 to headset
    /system/bin/tinymix 'LOOPBACK Mode' 'ENABLE' > /dev/null 2>&1
    /system/bin/tinymix 'DEC1 MUX' 'DMIC3' > /dev/null 2>&1
    /system/bin/tinymix 'IIR1 INP1 MUX' 'DEC1' > /dev/null 2>&1
    /system/bin/tinymix 'RX1 MIX1 INP1' 'IIR1' > /dev/null 2>&1
    /system/bin/tinymix 'RX2 MIX1 INP1' 'IIR1' > /dev/null 2>&1
    /system/bin/tinymix 'RDAC2 MUX' 'RX2' > /dev/null 2>&1
    /system/bin/tinymix 'HPHL' 'Switch' > /dev/null 2>&1
    /system/bin/tinymix 'HPHR' 'Switch' > /dev/null 2>&1
    /system/bin/tinymix 'IIR1 INP1 Volume' 84 > /dev/null 2>&1
    /system/bin/tinymix 'Loopback MCLK' 'ENABLE' > /dev/null 2>&1
		;;
	"20")
		#stop mic2 to headset
		/system/bin/tinymix 'DEC1 MUX' 'ZERO'  > /dev/null 2>&1
 		/system/bin/tinymix 'ADC2 MUX' 'ZERO'  > /dev/null 2>&1
		/system/bin/tinymix 'IIR1 INP1 MUX' 'ZERO'  > /dev/null 2>&1
		/system/bin/tinymix 'RX1 MIX1 INP1' 'ZERO'  > /dev/null 2>&1
		/system/bin/tinymix 'RX2 MIX1 INP1' 'ZERO'  > /dev/null 2>&1
		/system/bin/tinymix 'RDAC2 MUX' 'ZERO'  > /dev/null 2>&1
		/system/bin/tinymix 'HPHL' 'ZERO'  > /dev/null 2>&1
		/system/bin/tinymix 'HPHR' 'ZERO'  > /dev/null 2>&1
		/system/bin/tinymix 'Loopback MCLK' 'DISABLE' > /dev/null 2>&1
		/system/bin/tinymix 'LOOPBACK Mode' 'DISABLE' > /dev/null 2>&1
		/system/bin/tinymix 'IIR1 INP1 Volume' 309 > /dev/null 2>&1
		;;
	"31")
		#Do headset mic to headset
		/system/bin/tinymix 'LOOPBACK Mode' 'ENABLE' > /dev/null 2>&1
		/system/bin/tinymix 'DEC1 MUX' 'ADC2' > /dev/null 2>&1
		/system/bin/tinymix 'ADC2 MUX' 'INP2' > /dev/null 2>&1
		/system/bin/tinymix 'IIR1 INP1 MUX' 'DEC1' > /dev/null 2>&1
		/system/bin/tinymix 'RX1 MIX1 INP1' 'IIR1'  > /dev/null 2>&1
		/system/bin/tinymix 'RX2 MIX1 INP1' 'IIR1'  > /dev/null 2>&1
		/system/bin/tinymix 'RDAC2 MUX' 'RX2'  > /dev/null 2>&1
		/system/bin/tinymix 'HPHL' 'Switch'  > /dev/null 2>&1
		/system/bin/tinymix 'HPHR' 'Switch' > /dev/null 2>&1
		/system/bin/tinymix 'Loopback MCLK' 'ENABLE' > /dev/null 2>&1
		;;
	"30")
		#stop headset mic to headset
		/system/bin/tinymix 'DEC1 MUX' 'ZERO'  > /dev/null 2>&1
 		/system/bin/tinymix 'ADC2 MUX' 'ZERO'  > /dev/null 2>&1
		/system/bin/tinymix 'IIR1 INP1 MUX' 'ZERO'  > /dev/null 2>&1
		/system/bin/tinymix 'RX1 MIX1 INP1' 'ZERO'  > /dev/null 2>&1
		/system/bin/tinymix 'RX2 MIX1 INP1' 'ZERO'  > /dev/null 2>&1
		/system/bin/tinymix 'RDAC2 MUX' 'ZERO'  > /dev/null 2>&1
		/system/bin/tinymix 'HPHL' 'ZERO'  > /dev/null 2>&1
		/system/bin/tinymix 'HPHR' 'ZERO'  > /dev/null 2>&1
		/system/bin/tinymix 'Loopback MCLK' 'DISABLE' > /dev/null 2>&1
		/system/bin/tinymix 'LOOPBACK Mode' 'DISABLE' > /dev/null 2>&1
		/system/bin/tinymix 'IIR1 INP1 Volume' 309 > /dev/null 2>&1
		;;
	"41")
		#Do mic3 to headset
    /system/bin/tinymix 'LOOPBACK Mode' 'ENABLE' > /dev/null 2>&1
    /system/bin/tinymix 'DEC1 MUX' 'DMIC4' > /dev/null 2>&1
    /system/bin/tinymix 'IIR1 INP1 MUX' 'DEC1' > /dev/null 2>&1
    /system/bin/tinymix 'RX1 MIX1 INP1' 'IIR1' > /dev/null 2>&1
    /system/bin/tinymix 'RX2 MIX1 INP1' 'IIR1' > /dev/null 2>&1
    /system/bin/tinymix 'RDAC2 MUX' 'RX2' > /dev/null 2>&1
    /system/bin/tinymix 'HPHL' 'Switch' > /dev/null 2>&1
    /system/bin/tinymix 'HPHR' 'Switch' > /dev/null 2>&1
    /system/bin/tinymix 'IIR1 INP1 Volume' 84 > /dev/null 2>&1
    /system/bin/tinymix 'Loopback MCLK' 'ENABLE' > /dev/null 2>&1
		;;
	"40")
		#stop mic3 to headset
		/system/bin/tinymix 'DEC1 MUX' 'ZERO'  > /dev/null 2>&1
 		/system/bin/tinymix 'ADC2 MUX' 'ZERO'  > /dev/null 2>&1
		/system/bin/tinymix 'IIR1 INP1 MUX' 'ZERO'  > /dev/null 2>&1
		/system/bin/tinymix 'RX1 MIX1 INP1' 'ZERO'  > /dev/null 2>&1
		/system/bin/tinymix 'RX2 MIX1 INP1' 'ZERO'  > /dev/null 2>&1
		/system/bin/tinymix 'RDAC2 MUX' 'ZERO'  > /dev/null 2>&1
		/system/bin/tinymix 'HPHL' 'ZERO'  > /dev/null 2>&1
		/system/bin/tinymix 'HPHR' 'ZERO'  > /dev/null 2>&1
		/system/bin/tinymix 'Loopback MCLK' 'DISABLE' > /dev/null 2>&1
		/system/bin/tinymix 'LOOPBACK Mode' 'DISABLE' > /dev/null 2>&1
		/system/bin/tinymix 'IIR1 INP1 Volume' 309 > /dev/null 2>&1
		;;
	*)
		;; #Do nothing
esac
