# setup main mic
tinymix 'DEC1 MUX' 'ADC1'
tinymix 'ADC1_INP1 Switch' 1
tinymix 'DEC1 Volume' 84
tinymix 'ADC1 Volume' 4

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
