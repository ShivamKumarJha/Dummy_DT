# $1: audio source
#     0: default
#     1: main mic
#     2: top mic
#     3: back mic
#     4: front mic
# $2: sample rate(Hz)
# $3: sample bit
# $4: channel number
# $5: capture duration(s)
# tinycap file.wav [-D card] [-d device] [-c channels] [-r rate] [-b bits] [-p period_size] [-n n_periods] [-T duration]
# sample usage: capture.sh main-mic 48000 16 2 10

rate=KHZ_48
filename=/sdcard/unknown_mic.wav

case "$3" in
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
	tinymix 'ADC1 Volume' 6
}

function disable_main_mic
{
	echo "disabling main mic"
	tinymix 'DEC1 MUX' 'ZERO'
	tinymix 'ADC1 Volume' 4
}

function enable_top_mic
{
	echo "enabling top mic"
	tinymix 'DEC1 MUX' 'ADC2'
	tinymix 'ADC2 Volume' 6
}

function disable_top_mic
{
	echo "disabling top mic"
	tinymix 'DEC1 MUX' 'ZERO'
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

function enable_ultrasound_mic
{
	echo "enable ultrasound mic"
	tinymix 'Audio Stream Capture 0 App Type Cfg' 69938 19 48000 3
	tinymix 'INT3_MI2S_TX Channels' 'One'
	tinymix 'DEC1 MUX' 'ADC2'
	tinymix 'ADC2 MUX' 'INP3'
	tinymix 'DEC1 Volume' 84
	tinymix 'ADC3 Volume' 6
}

function disable_ultrasound_mic
{
	echo "disable ultrasound mic"
	tinymix 'INT3_MI2S_TX Channels' 'One'
	tinymix 'ADC2 MUX' 'INP3'
	tinymix 'DEC1 MUX' 'ZERO'
	tinymix 'DEC1 Volume' 84
	tinymix 'ADC3 Volume' 4
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
        filename=/sdcard/back_mic.wav
        ;;
    "front-mic" )
        enable_front_mic
        filename=/sdcard/front_mic.wav
        ;;
    "us" )
        enable_ultrasound_mic
        filename=/sdcard/us_mic.wav
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
tinycap $filename -r $2 -b $3 -c $4 -T $5 -p $period_size -n $n_periods
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
    "us" )
        disable_ultrasound_mic
        ;;
esac

tinymix 'MultiMedia1 Mixer INT3_MI2S_TX' 0
tinymix 'INT3_MI2S_TX SampleRate' KHZ_48
