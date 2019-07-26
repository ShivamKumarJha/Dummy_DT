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
	tinymix 'INT4_MI2S_RX Audio Mixer MultiMedia1' 1
	tinymix 'INT4_MI2S_RX Channels' 'One'
	tinymix 'RX4 MIX1 INP1' 'RX4'
	tinymix 'COMP1 Switch' 1
	tinymix 'SpkrLeft COMP Switch' 1
	tinymix 'SpkrLeft BOOST Switch' 1
	tinymix 'SpkrLeft VISENSE Switch' 1
	tinymix 'SpkrLeft SWR DAC_Port Switch' 1
	#tinymix 'EAR SPKR PA Gain' 'G_6_DB'

	#echo "0x311b 0x59" > /d/regmap/wsa881x.21170213/registers
}

function disable_receiver
{
	echo "disabling receiver"
	tinymix 'SpkrLeft SWR DAC_Port Switch' 0
	tinymix 'SpkrLeft VISENSE Switch' 0
	tinymix 'SpkrLeft BOOST Switch' 0
	tinymix 'SpkrLeft COMP Switch' 0
	#tinymix 'COMP1 Switch' 0
	tinymix 'RX4 MIX1 INP1' 'ZERO'
	tinymix 'INT4_MI2S_RX Audio Mixer MultiMedia1' 0
	#echo "0x311b 0x41" > /d/regmap/wsa881x.21170213/registers
}

function enable_speaker
{
	echo "enabling speaker"
	tinymix 'INT4_MI2S_RX Audio Mixer MultiMedia1' 1
	tinymix 'INT4_MI2S_RX Channels' 'One'
	tinymix 'RX5 MIX1 INP1' 'RX5'
	tinymix 'COMP2 Switch' 1
	tinymix 'SpkrRight COMP Switch' 1
	tinymix 'SpkrRight BOOST Switch' 1
	tinymix 'SpkrRight VISENSE Switch' 1
	tinymix 'SpkrRight SWR DAC_Port Switch' 1
}

function disable_speaker
{ echo "disabling speaker"
	tinymix 'SpkrRight SWR DAC_Port Switch' 0
	tinymix 'SpkrRight VISENSE Switch' 0
	tinymix 'SpkrRight BOOST Switch' 0
	tinymix 'SpkrRight COMP Switch' 0
	tinymix 'COMP2 Switch' 0
	tinymix 'RX5 MIX1 INP1' 'ZERO'
	tinymix 'INT4_MI2S_RX Audio Mixer MultiMedia1' 0
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
