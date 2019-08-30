#!/system/vendor/bin/sh
# add start FQC audio loopback qiujie 2018.0122
fqcaudio=`/vendor/bin/getprop debug.sys.fqcaudio`
case "$fqcaudio" in
    "11")
        /system/bin/tinymix 'LOOPBACK Mode' 1
        /system/bin/tinymix 'Loopback MCLK' 1
        /system/bin/tinymix 'DEC1 MUX' 'ADC1'
        /system/bin/tinymix 'ADC1 Volume' 6
        /system/bin/tinymix 'IIR1 INP1 MUX' 'DEC1'
        /system/bin/tinymix 'RX1 MIX1 INP1' 'IIR1'
        /system/bin/tinymix 'RX2 MIX1 INP1' 'IIR1'
        /system/bin/tinymix 'RDAC2 MUX' 'RX2'
        /system/bin/tinymix 'HPHL' 'Switch'
        /system/bin/tinymix 'HPHR' 'Switch'
        /system/bin/tinymix 'Headphone switch Mux' 'ENABLE'
    ;;
    "10")
        /system/bin/tinymix 'DEC1 MUX' 'ZERO'
        /system/bin/tinymix 'ADC1 Volume' 4
        /system/bin/tinymix 'IIR1 INP1 MUX' 'ZERO'
        /system/bin/tinymix 'RX1 MIX1 INP1' 'ZERO'
        /system/bin/tinymix 'RX2 MIX1 INP1' 'ZERO'
        /system/bin/tinymix 'RDAC2 MUX' 'ZERO'
        /system/bin/tinymix 'HPHL' 'ZERO'
        /system/bin/tinymix 'HPHR' 'ZERO'
        /system/bin/tinymix 'Loopback MCLK' 0
        /system/bin/tinymix 'LOOPBACK Mode' 0
    ;;
    "21")
        /system/bin/tinymix 'LOOPBACK Mode' 1
        /system/bin/tinymix 'Loopback MCLK' 1
        /system/bin/tinymix 'DEC1 MUX' 'ADC2'
        /system/bin/tinymix 'ADC3 Volume' 6
        /system/bin/tinymix 'ADC2 MUX' 'INP3'
        /system/bin/tinymix 'IIR1 INP1 MUX' 'DEC1'
        /system/bin/tinymix 'RX1 MIX1 INP1' 'IIR1'
        /system/bin/tinymix 'RX2 MIX1 INP1' 'IIR1'
        /system/bin/tinymix 'RDAC2 MUX' 'RX2'
        /system/bin/tinymix 'HPHL' 'Switch'
        /system/bin/tinymix 'HPHR' 'Switch'
        /system/bin/tinymix 'Headphone switch Mux' 'ENABLE'
    ;;
    "20")
        /system/bin/tinymix 'DEC1 MUX' 'ZERO'
        /system/bin/tinymix 'ADC1 Volume' 6
        /system/bin/tinymix 'ADC2 MUX' 'ZERO'
        /system/bin/tinymix 'IIR1 INP1 MUX' 'ZERO'
        /system/bin/tinymix 'RX1 MIX1 INP1' 'ZERO'
        /system/bin/tinymix 'RX2 MIX1 INP1' 'ZERO'
        /system/bin/tinymix 'RDAC2 MUX' 'ZERO'
        /system/bin/tinymix 'HPHL' 'ZERO'
        /system/bin/tinymix 'HPHR' 'ZERO'
        /system/bin/tinymix 'Loopback MCLK' 0
        /system/bin/tinymix 'LOOPBACK Mode' 0
    ;;
    "31")
        /system/bin/tinymix 'LOOPBACK Mode' 1
        /system/bin/tinymix 'Loopback MCLK' 1
        /system/bin/tinymix 'DEC1 MUX' 'ADC2'
        /system/bin/tinymix 'ADC2 Volume' 6
        /system/bin/tinymix 'ADC2 MUX' 'INP2'
        /system/bin/tinymix 'IIR1 INP1 MUX' 'DEC1'
        /system/bin/tinymix 'RX1 MIX1 INP1' 'IIR1'
        /system/bin/tinymix 'RX2 MIX1 INP1' 'IIR1'
        /system/bin/tinymix 'RDAC2 MUX' 'RX2'
        /system/bin/tinymix 'HPHL' 'Switch'
        /system/bin/tinymix 'HPHR' 'Switch'
        /system/bin/tinymix 'Headphone switch Mux' 'ENABLE'
    ;;
    "30")
        /system/bin/tinymix 'DEC1 MUX' 'ZERO'
        /system/bin/tinymix 'ADC2 Volume' 4
        /system/bin/tinymix 'ADC2 MUX' 'ZERO'
        /system/bin/tinymix 'IIR1 INP1 MUX' 'ZERO'
        /system/bin/tinymix 'RX1 MIX1 INP1' 'ZERO'
        /system/bin/tinymix 'RX2 MIX1 INP1' 'ZERO'
        /system/bin/tinymix 'RDAC2 MUX' 'ZERO'
        /system/bin/tinymix 'HPHL' 'ZERO'
        /system/bin/tinymix 'HPHR' 'ZERO'
        /system/bin/tinymix 'Loopback MCLK' 0
        /system/bin/tinymix 'LOOPBACK Mode' 0
    ;;
    *)
        setprop debug.sys.fqcaudio 0
    ;; #Do nothing
esac
# add end FQC audio loopback qiujie 2018.0122
