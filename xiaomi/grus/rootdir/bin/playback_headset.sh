# $1: wave file to read
# $2: device for output
#     0: current
#     1: speaker
#     2: receiver

# tinyplay file.wav [-D card] [-d device] [-p period_size] [-n n_periods]
# sample usage: playback.sh 2000.wav  1
sleep 10
tinymix 'INT0_MI2S_RX Audio Mixer MultiMedia1' 1
tinymix 'INT0_MI2S_RX Channels' 'Two'
tinymix 'RX1 MIX1 INP1' 'RX1'
tinymix 'RX2 MIX1 INP1' 'RX2'
tinymix 'RDAC2 MUX' 'RX2'
tinymix 'RX HPH Mode' 'HD2'
tinymix 'HPHL' 'Switch'
tinymix 'HPHR' 'Switch'
tinyplay /system/etc/test.wav
sleep 3

tinymix 'INT0_MI2S_RX Channels' 'One'
tinymix 'RX1 MIX1 INP1' 'ZERO'
tinymix 'RX2 MIX1 INP1' 'ZERO'
tinymix 'RDAC2 MUX' 'ZERO'
tinymix 'HPHL' 'ZERO'
tinymix 'HPHR' 'ZERO'
tinymix 'RX HPH Mode' 'ZERO'
tinymix 'INT0_MI2S_RX Audio Mixer MultiMedia1' 0
