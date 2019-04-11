#$1:device for output
#   spk: speaker
#   rcv: receiver
#   rcv_hp: headphone

# tinyplay file.wav [-D card] [-d device] [-p period_size] [-n n_periods]
# sample usage: playback.sh spk

function enable_receiver
{
	echo "enabling receiver"
    tinymix 'INT0_MI2S_RX Audio Mixer MultiMedia1' 1
    tinymix 'RX1 MIX1 INP1' 'RX1'
    tinymix 'RDAC2 MUX' 'RX1'
    tinymix 'EAR_S' 'Switch'
}

function disable_receiver
{
	echo "disabling receiver"
    tinymix 'RX1 MIX1 INP1' 'ZERO'
    tinymix 'RDAC2 MUX' 'ZERO'
    tinymix 'EAR_S' 'ZERO'
    tinymix 'INT0_MI2S_RX Audio Mixer MultiMedia1' 0
}

function enable_speaker
{
    echo "enabling speaker"
	tinymix 'SEC_MI2S_RX Audio Mixer MultiMedia1' 1
	tinymix 'SEC_MI2S_RX Channels' 'One'
	tinymix 'TFA Profile' 'bypass'
}

function disable_speaker
{
    echo "disabling speaker"
    tinymix 'TFA Profile' 'music'
    tinymix 'SEC_MI2S_RX Audio Mixer MultiMedia1' 0
}

function enable_headphone
{
	echo "enabling headphone"
	tinymix 'INT0_MI2S_RX Audio Mixer MultiMedia1' 1
	tinymix 'INT0_MI2S_RX Channels' 'Two'
	tinymix 'RX1 MIX1 INP1' 'RX1'
	tinymix 'RX2 MIX1 INP1' 'RX2'
	tinymix 'RDAC2 MUX' 'RX2'
	tinymix 'RX HPH Mode' 'HD2'
	tinymix 'HPHL' 'Switch'
	tinymix 'HPHR' 'Switch'
}

function disable_headphone
{
	echo "disabling headphone"
	tinymix 'INT0_MI2S_RX Channels' 'One'
	tinymix 'RX1 MIX1 INP1' 'ZERO'
	tinymix 'RX2 MIX1 INP1' 'ZERO'
	tinymix 'RDAC2 MUX' 'ZERO'
	tinymix 'HPHL' 'ZERO'
	tinymix 'HPHR' 'ZERO'
	tinymix 'RX HPH Mode' 'ZERO'
	tinymix 'INT0_MI2S_RX Audio Mixer MultiMedia1' 0
}

if [ "$1" = "spk" ]; then
	enable_speaker
	filename=/vendor/etc/spk.wav
elif [ "$1" = "rcv" ]; then
	enable_receiver
	filename=/vendor/etc/rcv.wav
elif [ "$1" = "rcv_hp" ]; then
	enable_receiver
	filename=/vendor/etc/rcv_hp.wav
else
	echo "Usage: playback.sh device; devices: spk or rcv"
fi

echo "start playing"
tinyplay $filename

if [ "$1" = "spk" ]; then
	disable_speaker
elif [ "$1" = "rcv"  ]; then
	disable_receiver
elif [ "$1" = "rcv_hp" ]; then
	disable_receiver
fi

exit 0
