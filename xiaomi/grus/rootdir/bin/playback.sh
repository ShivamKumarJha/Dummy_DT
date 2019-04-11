# $1: device for output
#     spk: speaker
#     rcv: receiver
#     rcv_hp: headphone
#     us: ultrasound

# tinyplay file.wav [-D card] [-d device] [-p period_size] [-n n_periods]
# sample usage: playback.sh spk

function enable_receiver
{
    echo "enabling receiver"
    tinymix 'INT0_MI2S_RX Audio Mixer MultiMedia1' 1
    tinymix "Audio Stream 0 App Type Cfg"  69936 10001 96000 145 0
    tinymix 'INT0_MI2S_RX SampleRate' 'KHZ_96'
    tinymix 'RX1 MIX1 INP1' 'RX1'
    tinymix 'RDAC2 MUX' 'RX1'
    tinymix 'EAR_S' 'Switch'
}

function disable_receiver
{
    echo "disabling receiver"
    tinymix 'INT0_MI2S_RX SampleRate' 'KHZ_48'
    tinymix 'RX1 MIX1 INP1' 'ZERO'
    tinymix 'RDAC2 MUX' 'ZERO'
    tinymix 'EAR_S' 'ZERO'
    tinymix 'INT0_MI2S_RX Audio Mixer MultiMedia1' 0
    tinymix 'Audio Stream 0 App Type Cfg'  69936 10001 48000 145 0
}

function enable_speaker
{
    echo "enabling speaker"
    tinymix 'PRI_MI2S_RX Audio Mixer MultiMedia1' 1
    tinymix 'PRI_MI2S_RX Channels' 'Two'
    tinymix 'PCM Source' 'ASP'
    tinymix 'AMP PCM Gain' 14
    tinymix 'ASP TX1 Source' 'DSPTX1'
    tinymix 'ASP TX2 Source' 'DSPTX1'
    tinymix 'Cirrus SP Usecase Config' 'None'
    tinymix 'Audio Stream 0 App Type Cfg'  69936 10001 48000 43 0
}

function disable_speaker
{
    echo "disabling speaker"
    tinymix 'Cirrus SP Usecase Config' 'Music'
    tinymix 'PCM Source' 'ASP'
    tinymix 'PRI_MI2S_RX Channels' 'Two'
    tinymix 'PRI_MI2S_RX Audio Mixer MultiMedia1' 0
    tinymix 'Audio Stream 0 App Type Cfg'  69936 10001 48000 43 0
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

function enable_ultrasound
{
    echo "enabling ultrasound"
    tinymix 'INT0_MI2S_RX Audio Mixer MultiMedia1' 1
    tinymix 'INT0_MI2S_RX SampleRate' 'KHZ_96'
    tinymix "Audio Stream 13 App Type Cfg"  69936 10001 96000 145 0
    tinymix 'RX1 MIX1 INP1' 'RX1'
    tinymix 'RDAC2 MUX' 'RX1'
    tinymix 'EAR_S' 'Switch'
}

function disable_ultrasound
{
    echo "disabling ultrasound"
    tinymix 'RX1 MIX1 INP1' 'ZERO'
    tinymix 'RDAC2 MUX' 'ZERO'
    tinymix 'EAR_S' 'ZERO'
    tinymix 'INT0_MI2S_RX SampleRate' 'KHZ_48'
    tinymix 'INT0_MI2S_RX Audio Mixer MultiMedia1' 0
    tinymix 'Audio Stream 13 App Type Cfg'  69936 10001 48000 145 0
}

if [ "$1" = "spk" ]; then
    enable_speaker
    filename=/vendor/etc/spk.wav
elif [ "$1" = "rcv" ]; then
    enable_receiver
    filename=/vendor/etc/rcv.wav
elif [ "$1" = "rcv_hp" ]; then
    enable_headphone
    filename=/vendor/etc/rcv_hp.wav
elif [ "$1" = "us" ]; then
    enable_ultrasound
    filename=/vendor/etc/ultrasound.wav
else
    echo "Usage: playback.sh device; device: spk or rcv or rcv_hp or us"
fi

echo "start playing"
tinyplay $filename

if [ "$1" = "spk" ]; then
    disable_speaker
elif [ "$1" = "rcv" ]; then
    disable_receiver
elif [ "$1" = "rcv_hp" ]; then
    disable_headphone
elif [ "$1" = "us" ]; then
    disable_ultrasound
fi

exit 0
