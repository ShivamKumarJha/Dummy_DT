# $1: audio source
#     main-mic: main mic
#     top-mic: top mic
#     back-mic: back mic
#     front-mic: front mic
#     us: ultrasound
# $2: sample rate(Hz)
# $3: sample bit
# $4: channel number
# $5: capture duration(s)
# tinycap file.wav [-D card] [-d device] [-c channels] [-r rate] [-b bits] [-p period_size] [-n n_periods] [-t duration]
# sample usage: capture.sh main-mic 48000 16 2 10

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
    tinymix 'DEC7 Volume' 84
    tinymix 'ADC3 Volume' 12
    tinymix 'DEC8 Volume' 84
    tinymix 'ADC4 Volume' 12
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
    tinymix 'ADC1 Volume' 12
    tinymix 'ADC2 Volume' 12
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
    tinymix 'DEC7 Volume' 84
    tinymix 'DEC8 Volume' 84
    tinymix 'ADC1 Volume' 12
    tinymix 'ADC2 Volume' 12
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
    tinymix 'Audio Stream Capture 0 App Type Cfg' 69938 19 96000 3
    tinymix 'SLIM_0_TX Channels' 'One'
    tinymix 'AIF1_CAP Mixer SLIM TX7' 1
    tinymix 'CDC_IF TX7 MUX' 'DEC7'
    tinymix 'ADC MUX7' 'AMIC'
    tinymix 'AMIC MUX7' 'ADC1'
    tinymix 'ADC1 Volume' 6
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
    tinymix 'ADC1 Volume' 12
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

if [ -z "$7" ]; then
    n_periods=4
else
    n_periods=$7
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

tinymix 'MultiMedia1 Mixer SLIM_0_TX' 0
tinymix 'SLIM_0_TX SampleRate' 'KHZ_48'
