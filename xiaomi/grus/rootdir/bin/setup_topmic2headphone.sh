# setup top mic
tinymix 'DEC1 MUX' 'ADC2'
tinymix 'ADC2 MUX' 'INP3'

# setup headphone
tinymix 'LOOPBACK Mode' 'ENABLE'
tinymix 'RDAC2 MUX' 'RX2'
tinymix 'IIR1 INP1 MUX' 'DEC1'
tinymix 'RX1 MIX1 INP1' 'IIR1'
tinymix 'RX2 MIX1 INP2' 'IIR1'
tinymix 'HPHL' 'Switch'
tinymix 'HPHR' 'Switch'
tinymix 'RX2 MIX1 INP2' 'IIR1'
tinymix 'Loopback MCLK' 'ENABLE'
