# $1: audio source
#     main-mic: main mic
#     top-mic: top mic
#     back-mic: back mic
#     front-mic: front mic
#     headset-mic: headset mic
# $2: sample rate(Hz)
# $3: sample bit
# $4: channel number
# $5: capture duration(s)
# tinycap file.wav [-D card] [-d device] [-c channels] [-r rate] [-b bits] [-p period_size] [-n n_periods] [-t duration]
# sample usage: capture.sh main-mic 48000 16 2 10

rate=KHZ_48
period_size=1024
n_periods=4

case "$2" in
	"48000" )
		rate=KHZ_48
		;;
	"96000" )
		rate=KHZ_96
		;;
	"192000" )
		rate=KHZ_192
		;;
esac

function enable_main_mic
{
	echo "enabling main mic"
	tinymix 'DEC1 MUX' 'ADC1'
	tinymix 'ADC1_INP1 Switch' 1
	tinymix 'DEC1 Volume' 84
	tinymix 'ADC1 Volume' 4
}

function disable_main_mic
{
	echo "disabling main mic"
	tinymix 'DEC1 MUX' 'ZERO'
	tinymix 'ADC1_INP1 Switch' 0
	tinymix 'DEC1 Volume' 84
	tinymix 'ADC1 Volume' 4
}

function enable_top_mic
{
	echo "enabling top mic"
	tinymix 'DEC1 MUX' 'ADC2'
	tinymix 'ADC2 MUX' 'INP3'
	tinymix 'DEC1 Volume' 84
	tinymix 'ADC2 Volume' 4
}

function disable_top_mic
{
	echo "disabling top mic"
	tinymix 'ADC2 MUX' 'ZERO'
	tinymix 'DEC1 MUX' 'ZERO'
	tinymix 'DEC1 Volume' 84
	tinymix 'ADC2 Volume' 4
}

function enable_back_mic
{
	echo "PHONE HAS NO BACK MIC!"
}

function disable_back_mic
{
	echo "PHONE HAS NO BACK MIC!"
}

function enable_front_mic
{
	echo "PHONE HAS NO FRONT MIC!"
}

function disable_front_mic
{
	echo "PHONE HAS NO FRONT MIC!"
}

function enable_headset_mic
{
	echo "enabling headset mic"
	tinymix 'DEC1 MUX' 'ADC2'
	tinymix 'ADC2 MUX' 'INP2'
	tinymix 'DEC1 Volume' 84
	tinymix 'ADC2 Volume' 4
}

function disable_headset_mic
{
	echo "disbaling headset mic"
	tinymix 'DEC1 MUX' 'ZERO'
	tinymix 'ADC2 MUX' 'ZERO'
	tinymix 'DEC1 Volume' 84
	tinymix 'ADC2 Volume' 4
}

# setup
tinymix 'MultiMedia1 Mixer INT3_MI2S_TX' 1
tinymix 'INT3_MI2S_TX SampleRate' $rate

case "$1" in
	"main-mic" )
		enable_main_mic
		filename=/sdcard/main_mic.wav
		;;
	"top-mic" )
		enable_top_mic
		filename=/sdcard/top_mic.wav
		;;
	"back-mic" )
		enable_back_mic
		;;
	"front-mic" )
		enable_front_mic
		;;
	"headset-mic" )
		enable_headset_mic
		;;
	*)
	echo "Usage: capture.sh main-mic 48000 16 2 10"
		;;
esac

if [ -z "$6" ]; then
	period_size=1024
else
	period_size=$6
fi

if [ -z "$7" ]; then
	n_periods=4
else
	n_periods=$7
fi

echo "start recording"
tinycap $filename -r $2 -b $3 -t $5 -p $period_size -n $n_periods
ret=$?
if [ $ret -ne 0 ]; then
	echo "tinycap done, return $ret"
fi

# tear down
case "$1" in
	"main-mic" )
		disable_main_mic
		;;
	"top-mic" )
		disable_top_mic
		;;
	"back-mic" )
		disable_back_mic
		;;
	"front-mic" )
		disable_front_mic
		;;
	"headset-mic" )
		disable_headset_mic
		;;

esac

tinymix 'MultiMedia1 Mixer INT3_MI2S_TX' 0
tinymix 'INT3_MI2S_TX SampleRate' KHZ_48
