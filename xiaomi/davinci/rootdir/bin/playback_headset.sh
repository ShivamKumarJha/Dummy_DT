# $1: wave file to read
# $2: device for output
#     0: current
#     1: speaker
#     2: receiver

# tinyplay file.wav [-D card] [-d device] [-p period_size] [-n n_periods]
# sample usage: playback.sh 2000.wav  1
sleep 10
tinymix "RX_MACRO RX0 MUX" "AIF1_PB"
tinymix "RX_MACRO RX1 MUX" "AIF1_PB"
tinymix "RX_CDC_DMA_RX_0 Channels" "Two"
tinymix "RX INT0_1 MIX1 INP0" "RX0"
tinymix "RX INT1_1 MIX1 INP0" "RX1"
tinymix "RX INT0 DEM MUX" "CLSH_DSM_OUT"
tinymix "RX INT1 DEM MUX" "CLSH_DSM_OUT"
tinymix "HPHL_RDAC Switch" "1"
tinymix "HPHR_RDAC Switch" "1"
tinymix "RX_CDC_DMA_RX_0 Audio Mixer MultiMedia1" "1"
tinyplay /vendor/etc/test.wav
sleep 3

tinymix "RX_MACRO RX0 MUX" "ZERO"
tinymix "RX_MACRO RX1 MUX" "ZERO"
tinymix "RX INT0_1 MIX1 INP0" "ZERO"
tinymix "RX INT1_1 MIX1 INP0" "ZERO"
tinymix "RX INT0 DEM MUX" "ZERO"
tinymix "RX INT1 DEM MUX" "ZERO"
tinymix "HPHL_RDAC Switch" "0"
tinymix "HPHR_RDAC Switch" "0"
tinymix "RX_CDC_DMA_RX_0 Audio Mixer MultiMedia1" "0"
