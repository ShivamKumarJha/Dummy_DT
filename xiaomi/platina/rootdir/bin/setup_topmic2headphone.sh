# setup top mic
tinymix 'DEC1 MUX' 'ADC2'
tinymix 'ADC2 MUX' 'INP3'
tinymix 'DEC1 Volume' 84
tinymix 'ADC2 Volume' 4

# setup headphone
tinymix 'LOOPBACK Mode' 'ENABLE'
tinymix 'RDAC2 MUX' 'RX2'
tinymix 'IIR1 INP1 MUX' 'DEC1'
tinymix 'RX1 MIX1 INP1' 'IIR1'
tinymix 'RX2 MIX1 INP2' 'IIR1'
tinymix 'HPHL' 'Switch'
tinymix 'HPHR' 'Switch'
tinymix 'Loopback MCLK' 'ENABLE'
tinymix 'IIR1 INP1 Volume' 84
tinymix 'RX1 Digital Volume' 84
tinymix 'RX2 Digital Volume' 84
