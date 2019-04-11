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
# sample usage: capture.sh /data/test1.wav 1 48000 16 2 10 1024 4

rate=KHZ_192
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
	tinymix 'SLIM_0_TX Channels' 'Two'
	tinymix 'AIF1_CAP Mixer SLIM TX7' 1
	tinymix 'AIF1_CAP Mixer SLIM TX8' 1
	tinymix 'CDC_IF TX8 MUX' 'DEC8'
	tinymix 'CDC_IF TX7 MUX' 'DEC7'
	tinymix 'ADC MUX7' 'AMIC'
	tinymix 'ADC MUX8' 'AMIC'
	tinymix 'AMIC MUX8' 'ADC4'
	tinymix 'AMIC MUX7' 'ADC3'

	tinymix 'AMIC4_5 SEL' 'AMIC4'
	tinymix 'DEC8 Volume' 84
	tinymix 'ADC4 Volume' 12
	tinymix 'DEC7 Volume' 84
	tinymix 'ADC3 Volume' 12
}

function disable_main_mic
{
	echo "disabling main mic"
	tinymix 'SLIM_0_TX Channels' 'One'
	tinymix 'AIF1_CAP Mixer SLIM TX7' 0
	tinymix 'AIF1_CAP Mixer SLIM TX8' 0
	tinymix 'CDC_IF TX7 MUX' 'ZERO'
	tinymix 'CDC_IF TX8 MUX' 'ZERO'
	tinymix 'AMIC MUX8' 'ZERO'
	tinymix 'AMIC MUX7' 'ZERO'
	tinymix 'DEC8 Volume' 84
	tinymix 'ADC4 Volume' 12
	tinymix 'DEC7 Volume' 84
	tinymix 'ADC3 Volume' 12
}

function enable_top_mic
{
	echo "enabling top mic"
	tinymix 'SLIM_0_TX Channels' 'Two'
	tinymix 'AIF1_CAP Mixer SLIM TX7' 1
	tinymix 'AIF1_CAP Mixer SLIM TX8' 1
	tinymix 'CDC_IF TX7 MUX' 'DEC7'
	tinymix 'CDC_IF TX8 MUX' 'DEC8'
	tinymix 'ADC MUX7' 'AMIC'
	tinymix 'ADC MUX8' 'AMIC'
	tinymix 'AMIC MUX7' 'ADC1'
	tinymix 'AMIC MUX8' 'ADC2'
	tinymix 'External AMIC2 Mux' 'Dual_ADC'
	tinymix 'ADC1 Volume' 6
	tinymix 'ADC2 Volume' 6
	tinymix 'DEC7 Volume' 84
	tinymix 'DEC8 Volume' 84
}

function disable_top_mic
{
	echo "disabling top mic"
	tinymix 'SLIM_0_TX Channels' 'One'
	tinymix 'AIF1_CAP Mixer SLIM TX7' 0
	tinymix 'AIF1_CAP Mixer SLIM TX8' 0
	tinymix 'CDC_IF TX8 MUX' 'ZERO'
	tinymix 'CDC_IF TX7 MUX' 'ZERO'
	tinymix 'AMIC MUX8' 'ZERO'
	tinymix 'AMIC MUX7' 'ZERO'
	tinymix 'External AMIC2 Mux' 'default'
	tinymix 'ADC1 Volume' 12
	tinymix 'ADC2 Volume' 12
	tinymix 'DEC7 Volume' 84
	tinymix 'DEC8 Volume' 84
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
	echo "ultrasound mic"
	tinymix 'Audio Stream Capture 0 App Type Cfg' 69938 19 96000 3
	tinymix 'AIF1_CAP Mixer SLIM TX7' 1
	tinymix 'CDC_IF TX7 MUX' 'DEC7'
	tinymix 'SLIM_0_TX Channels' 'One'
	tinymix 'ADC MUX7' 'AMIC'
	tinymix 'AMIC MUX7' 'ADC4'
	tinymix 'AMIC4_5 SEL' 'AMIC5'
	tinymix 'DEC7 Volume' 84
	tinymix 'ADC4 Volume' 12
}

function disable_front_mic
{
	echo "ultrasound mic"
	tinymix 'SLIM_0_TX Channels' 'One'
	tinymix 'AIF1_CAP Mixer SLIM TX7' 0
	tinymix 'CDC_IF TX7 MUX' 'ZERO'
	tinymix 'AMIC MUX7' 'ZERO'
	tinymix 'DEC7 Volume' 84
	tinymix 'ADC4 Volume' 12
}

# setup
tinymix 'MultiMedia1 Mixer SLIM_0_TX' 1
tinymix 'SLIM_0_TX SampleRate' $rate

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
# start recording
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
esac

tinymix 'MultiMedia1 Mixer SLIM_0_TX' 0
tinymix 'SLIM_0_TX SampleRate' 'KHZ_48'
