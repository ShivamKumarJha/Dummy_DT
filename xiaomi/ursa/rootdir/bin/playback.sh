# $1: wave file to read
# $2: device for output
#     0: current
#     1: speaker
#     2: receiver

# tinyplay file.wav [-D card] [-d device] [-p period_size] [-n n_periods]
# sample usage: playback.sh 2000.wav  1

function enable_receiver
{
	echo "enabling receiver"
	tinymix 'SLIM RX0 MUX' 'AIF1_PB'
	tinymix 'CDC_IF RX0 MUX' 'SLIM RX0'
	tinymix 'SLIM_0_RX Channels' 'One'
	tinymix 'RX INT0_1 MIX1 INP0' 'RX0'
	tinymix 'SLIMBUS_0_RX Audio Mixer MultiMedia1' 1
	tinymix 'RX INT0 DEM MUX' 'CLSH_DSM_OUT'
	tinymix 'EAR PA Gain' 'G_6_DB'
}

function disable_receiver
{
	echo "disabling receiver"
	tinymix 'SLIM RX0 MUX' 'ZERO'
	tinymix 'RX INT0_1 MIX1 INP0' 'ZERO'
	tinymix 'SLIMBUS_0_RX Audio Mixer MultiMedia1' 0
	tinymix 'RX INT0 DEM MUX' 'CLSH_DSM_OUT'
}

function enable_speaker
{
	echo "enabling speaker"
	tinymix 'QUAT_MI2S_RX Audio Mixer MultiMedia1' 1
	tinymix 'QUAT_MI2S_RX Channels' 'Two'
	tinymix 'Program' 1
	sleep 1
}

function disable_speaker
{
	echo "disabling speaker"
	tinymix 'Program' 0
	tinymix 'QUAT_MI2S_RX Channels' 'Two'
	tinymix 'QUAT_MI2S_RX Audio Mixer MultiMedia1' 0
}

if [ "$2" -eq "1" ]; then
	enable_speaker
elif [ "$2" -eq "2" ]; then
	enable_receiver
fi

echo "start playing"
tinyplay $1

if [ "$2" -eq "1" ]; then
	disable_speaker
elif [ "$2" -eq "2" ]; then
	disable_receiver
fi

exit 0
