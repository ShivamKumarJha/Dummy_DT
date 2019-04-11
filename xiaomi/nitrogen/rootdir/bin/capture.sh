# $1: wave file to write
# $2: audio source
#     0: default
#     1: main mic
#     2: top mic
#     3: back mic
#     4: front mic
#     5: headset mic
# $3: sample rate(Hz)
# $4: sample bit
# $5: channel number
# $6: capture duration(s)
# tinycap file.wav [-D card] [-d device] [-c channels] [-r rate] [-b bits] [-p period_size] [-n n_periods] [-t duration]
# sample usage: capture.sh /data/test1.wav 1 48000 16 2 10 1024 4

rate=KHZ_48
period_size=1024
n_periods=4

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

case "$2" in
	"1" )
		enable_main_mic
		;;
	"2" )
		enable_top_mic
		;;
	"3" )
		enable_back_mic
		;;
	"4" )
		enable_front_mic
		;;
	"5" )
		enable_headset_mic
		;;

esac

if [ -z "$7" ]; then
	period_size=1024
else
	period_size=$7
fi

if [ -z "$8" ]; then
	n_periods=4
else
	n_periods=$8
fi

echo "start recording"
tinycap $1 -r $3 -b $4 -t $6 -p $period_size -n $n_periods
ret=$?
if [ $ret -ne 0 ]; then
	echo "tinycap done, return $ret"
fi

# tear down
case "$2" in
	"1" )
		disable_main_mic
		;;
	"2" )
		disable_top_mic
		;;
	"3" )
		disable_back_mic
		;;
	"4" )
		disable_front_mic
		;;
	"5" )
		disable_headset_mic
		;;

esac

tinymix 'MultiMedia1 Mixer INT3_MI2S_TX' 0
tinymix 'INT3_MI2S_TX SampleRate' KHZ_48
