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
	tinymix "TX DEC0 MUX" "SWR_MIC"
	tinymix "TX SMIC MUX0" "ADC0"
	tinymix "TX_CDC_DMA_TX_3 Channels" "One"
	tinymix "TX_AIF1_CAP Mixer DEC0" "1"
	tinymix "ADC1_MIXER Switch" "1"
	tinymix "ADC1 Volume" "12"
}

function disable_main_mic
{
	echo "disabling main mic"
	tinymix "TX SMIC MUX0" "ZERO"
	tinymix "TX_CDC_DMA_TX_3 Channels" "One"
	tinymix "TX_AIF1_CAP Mixer DEC0" "0"
	tinymix "ADC1_MIXER Switch" "0"
}

function enable_top_mic
{
	echo "enabling top mic"
	tinymix "TX DEC0 MUX" "SWR_MIC"
	tinymix "TX SMIC MUX0" "ADC2"
	tinymix "TX_CDC_DMA_TX_3 Channels" "One"
	tinymix "TX_AIF1_CAP Mixer DEC0" "1"
	tinymix "ADC2_MIXER Switch" "1"
	tinymix "ADC2 MUX" "INP3"
	tinymix "ADC2 Volume" "12"
}

function disable_top_mic
{
	echo "disabling top mic"
	tinymix "TX SMIC MUX0" "ZERO"
	tinymix "TX_CDC_DMA_TX_3 Channels" "One"
	tinymix "TX_AIF1_CAP Mixer DEC0" "0"
	tinymix "ADC2_MIXER Switch" "0"
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
tinymix 'MultiMedia1 Mixer TX_CDC_DMA_TX_3' 1
tinymix 'TX_CDC_DMA_TX_3 SampleRate' $rate

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
tinycap $filename -r $2 -b $3 -T $5 -p $period_size -n $n_periods
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

tinymix 'MultiMedia1 Mixer TX_CDC_DMA_TX_3' 0
tinymix 'TX_CDC_DMA_TX_3 SampleRate' 'KHZ_48'
