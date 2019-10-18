echo "setup headsetmic"
tinymix 'ADC MUX7' 'AMIC'
tinymix 'AMIC MUX7' 'ADC2'
tinymix 'IIR0 INP0 MUX' 'DEC7'
tinymix 'IIR0 INP0 Volume' 84
tinymix 'DEC7 Volume' 84
tinymix 'ADC2 Volume' 4

echo "setup earpiece
tinymix 'RX INT0 MIX2 INP' 'SRC0'
tinymix 'RX INT0 DEM MUX' 'CLSH_DSM_OUT'
tinymix 'EAR PA Gain' 'G_6_DB'
tinymix 'RX0 Digital Volume' 84
