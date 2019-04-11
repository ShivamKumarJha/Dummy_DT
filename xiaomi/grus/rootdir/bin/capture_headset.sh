# $1: wave file to write
# $2: audio source
#     0: default
#     1: main mic
#     2: top mic
#     3: back mic
#     4: front mic
# $3: sample rate(Hz)
# $4: sample bit
# $5: channel number
# $6: capture duration(s)
# tinycap file.wav [-D card] [-d device] [-c channels] [-r rate] [-b bits] [-p period_size] [-n n_periods] [-t duration]
# sample usage: capture_audio.sh /data/test1.wav 1 48000 16 2 10

sleep 10
rate=KHZ_48


function enable_headset_mic
{
	echo "enabling main mic"
	tinymix 'DEC1 MUX' 'ADC2'
	tinymix 'ADC2 MUX' 'INP2'
	tinymix 'DEC1 Volume' 84
	tinymix 'ADC2 Volume' 6
}

function disable_headset_mic
{
	echo "disabling main mic"
	tinymix 'ADC2 MUX' 'ZERO'
	tinymix 'DEC1 MUX' 'ZERO'
	tinymix 'DEC1 Volume' 84
	tinymix 'ADC2 Volume' 4
}

# setup
tinymix 'MultiMedia1 Mixer INT3_MI2S_TX' 1
tinymix 'INT3_MI2S_TX SampleRate' $rate

enable_headset_mic

# start recording
tinycap /data/test1.wav -r 48000 -b 16 -t 10

disable_headset_mic

tinymix 'MultiMedia1 Mixer INT3_MI2S_TX' 0
tinymix 'INT3_MI2S_TX SampleRate' 'KHZ_48'
