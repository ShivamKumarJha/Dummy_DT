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
	tinymix 'QUAT_MI2S_RX Audio Mixer MultiMedia1' 1
	tinymix 'QUAT_MI2S_RX Channels' 'Two'
	tinymix 'TFA Profile' 'bypass_ear'
}

function disable_receiver
{
	echo "disabling receiver"
	tinymix 'TFA Profile' 'Powerdown'
	tinymix 'QUAT_MI2S_RX Channels' 'Two'
	tinymix 'QUAT_MI2S_RX Audio Mixer MultiMedia1' 0
}

function enable_speaker
{
	echo "enabling speaker"
	tinymix 'QUAT_MI2S_RX Audio Mixer MultiMedia1' 1
	tinymix 'QUAT_MI2S_RX Channels' 'Two'
	tinymix 'TFA Profile' 'bypass_spk'
}

function disable_speaker
{
	echo "disabling speaker"
	tinymix 'TFA Profile' 'Powerdown'
	tinymix 'QUAT_MI2S_RX Channels' 'Two'
	tinymix 'QUAT_MI2S_RX Audio Mixer MultiMedia1' 0
}

if [ "$2" -eq "1" ]; then
	enable_speaker
elif [ "$2" -eq "2" ]; then
	enable_receiver
fi

tinyplay $1

if [ "$2" -eq "1" ]; then
	disable_speaker
elif [ "$2" -eq "2" ]; then
	disable_receiver
fi

exit 0
