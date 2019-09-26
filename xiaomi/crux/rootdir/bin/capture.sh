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
# sample usage: capture_audio.sh /data/test1.wav 1 48000 16 2 10

rate=KHZ_192
filename=/sdcard/unknown_mic.wav

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
    tinymix 'AIF1_CAP Mixer SLIM TX7' 1
    tinymix 'CDC_IF TX7 MUX' 'DEC7'
    tinymix 'SLIM_0_TX Channels' 'One'
    tinymix 'ADC MUX7' 'AMIC'
    tinymix 'AMIC MUX7' 'ADC3'
    tinymix 'DEC7 Volume' 84
    tinymix 'ADC3 Volume' 5
}

function disable_main_mic
{
    echo "disabling main mic"
    tinymix 'SLIM_0_TX Channels' 'One'
    tinymix 'AIF1_CAP Mixer SLIM TX7' 0
    tinymix 'CDC_IF TX7 MUX' 'ZERO'
    tinymix 'AMIC MUX7' 'ZERO'
    tinymix 'DEC7 Volume' 84
    tinymix 'ADC3 Volume' 8
}

function enable_top_mic
{
    echo "enabling top mic"
    tinymix 'AIF1_CAP Mixer SLIM TX7' 1
    tinymix 'CDC_IF TX7 MUX' 'DEC7'
    tinymix 'SLIM_0_TX Channels' 'One'
    tinymix 'ADC MUX7' 'AMIC'
    tinymix 'AMIC MUX7' 'ADC1'
    tinymix 'DEC7 Volume' 84
    tinymix 'ADC1 Volume' 5

}

function disable_top_mic
{
    echo "disabling top mic"
    tinymix 'SLIM_0_TX Channels' 'One'
    tinymix 'AIF1_CAP Mixer SLIM TX7' 0
    tinymix 'CDC_IF TX7 MUX' 'ZERO'
    tinymix 'AMIC MUX7' 'ZERO'
    tinymix 'DEC7 Volume' 84
    tinymix 'ADC1 Volume' 8
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
    tinymix 'AIF1_CAP Mixer SLIM TX7' 1
    tinymix 'CDC_IF TX7 MUX' 'DEC7'
    tinymix 'SLIM_0_TX Channels' 'One'
    tinymix 'ADC MUX7' 'AMIC'
    tinymix 'AMIC MUX7' 'ADC2'
    tinymix 'DEC7 Volume' 84
    tinymix 'ADC2 Volume' 5
}

function disable_headset_mic
{
    echo "disabling headset mic"
    tinymix 'SLIM_0_TX Channels' 'One'
    tinymix 'AIF1_CAP Mixer SLIM TX7' 0
    tinymix 'CDC_IF TX7 MUX' 'ZERO'
    tinymix 'AMIC MUX7' 'ZERO'
    tinymix 'DEC7 Volume' 84
    tinymix 'ADC2 Volume' 8
}

function enable_ultrasound_mic
{
    echo "enable ultrasound mic"
    tinymix 'Audio Stream Capture 0 App Type Cfg' 69938 19 96000 3
    tinymix 'SLIM_0_TX Channels' 'One'
    tinymix 'AIF1_CAP Mixer SLIM TX7' 1
    tinymix 'CDC_IF TX7 MUX' 'DEC7'
    tinymix 'ADC MUX7' 'AMIC'
    tinymix 'AMIC MUX7' 'ADC1'
    tinymix 'ADC1 Volume' 10
    tinymix 'DEC7 Volume' 84
}

function disable_ultrasound_mic
{
    echo "disable ultrasound mic"
    tinymix 'SLIM_0_TX Channels' 'One'
    tinymix 'AIF1_CAP Mixer SLIM TX7' 0
    tinymix 'CDC_IF TX7 MUX' 'ZERO'
    tinymix 'AMIC MUX7' 'ZERO'
    tinymix 'DEC7 Volume' 84
    tinymix 'ADC1 Volume' 8
}

# setup
tinymix 'MultiMedia1 Mixer SLIM_0_TX' 1
tinymix 'SLIM_0_TX SampleRate' $rate

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


# start recording
echo "start recording"
tinycap $filename -r $2 -b $3 -t $5 -p $period_size -n $n_periods
ret=$?
if [ $ret -ne 0 ]; then
	echo "tinycap done, return $ret"
fi

# tear down
case "$1" in
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

tinymix 'MultiMedia1 Mixer SLIM_0_TX' 0
tinymix 'SLIM_0_TX SampleRate' 'KHZ_48'
