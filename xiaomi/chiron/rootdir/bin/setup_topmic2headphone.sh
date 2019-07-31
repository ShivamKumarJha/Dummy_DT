# setup top mic
tinymix 'ADC MUX7' 'AMIC'
tinymix 'ADC MUX8' 'AMIC'
tinymix 'AMIC MUX7' 'ADC3'
tinymix 'AMIC MUX8' 'ADC6'
tinymix 'IIR0 INP0 MUX' 'DEC7'
tinymix 'IIR1 INP0 MUX' 'DEC8'
tinymix 'DEC7 Volume' 84
tinymix 'DEC8 Volume' 84
tinymix 'ADC3 Volume' 0
tinymix 'ADC6 Volume' 0
tinymix 'IIR0 INP0 Volume' 84
tinymix 'IIR1 INP0 Volume' 84

# setup headphone
tinymix 'RX INT1_1 MIX1 INP0' 'IIR0'
tinymix 'RX INT2_1 MIX1 INP0' 'IIR1'
tinymix 'RX INT1 DEM MUX' 'CLSH_DSM_OUT'
tinymix 'RX INT2 DEM MUX' 'CLSH_DSM_OUT'
tinymix 'HPHL Volume' 20
tinymix 'HPHR Volume' 20
tinymix 'RX1 Digital Volume' 84
tinymix 'RX2 Digital Volume' 84
