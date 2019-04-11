set -x
# $1: device for output
#     spk: speaker
#     rcv: receiver
#     spk_hp: speaker high power
#     us: ultrasound

# tinyplay file.wav [-D card] [-d device] [-p period_size] [-n n_periods]
# sample usage: playback.sh spk
# rcv.wav:-4.5dbfs   spk: -4.8dbfs  ultra: -4.5dbfs  spk_hp:-1.8dbfs

function enable_receiver
{
    echo "enabling receiver"
    tinymix 'SLIM RX0 MUX' 'AIF1_PB'
    tinymix 'CDC_IF RX0 MUX' 'SLIM RX0'
    tinymix 'SLIM_0_RX Channels' 'One'
    tinymix 'RX INT0_1 MIX1 INP0' 'RX0'
    tinymix 'SLIMBUS_0_RX Audio Mixer MultiMedia1' 1
    tinymix 'RX INT0 DEM MUX' 'CLSH_DSM_OUT'
    tinymix 'EAR PA Gain' 'G_6_DB'
    tinymix 'RX0 Digital Volume' 84
}

function disable_receiver
{
    echo "disabling receiver"
    tinymix 'SLIM RX0 MUX' 'ZERO'
    tinymix 'RX INT0_1 MIX1 INP0' 'ZERO'
    tinymix 'SLIMBUS_0_RX Audio Mixer MultiMedia1' 0
    tinymix 'RX INT0 DEM MUX' 'CLSH_DSM_OUT'
}

function enable_speaker
{
    echo "enabling speaker"
    tinymix 'QUAT_MI2S_RX Audio Mixer MultiMedia1' 1
    tinymix 'QUAT_MI2S_RX Channels' 'Two'
    tinymix 'PCM Source' 'ASP'
    #tinymix 'PCM Source' 'DSP'
    tinymix 'AMP PCM Gain' 14
    tinymix 'ASP TX1 Source' 'DSPTX1'
    tinymix 'ASP TX2 Source' 'DSPTX1'
    #tinymix 'Cirrus SP Volume Attenuation' '-18dB'
    tinymix 'Cirrus SP Usecase Config' 'None'

    sleep 1
}

function disable_speaker
{
    echo "disabling speaker"
    tinymix 'Cirrus SP Usecase Config' 'Music'
    #TODO: use DSP after pa fw loaded
    #tinymix 'PCM Source' 'DSP'
    tinymix 'PCM Source' 'ASP'
    tinymix 'QUAT_MI2S_RX Channels' 'Two'
    tinymix 'QUAT_MI2S_RX Audio Mixer MultiMedia1' 0
}

function enable_ultrasound
{
    echo "enable ultrasound"
    tinymix 'SLIM_0_RX SampleRate' 'KHZ_96'
    tinymix 'SLIM RX0 MUX' 'AIF1_PB'
    tinymix 'CDC_IF RX0 MUX' 'SLIM RX0'
    tinymix 'SLIM_0_RX Channels' 'One'
    tinymix 'RX INT0_1 MIX1 INP0' 'RX0'
    tinymix 'SLIMBUS_0_RX Audio Mixer MultiMedia1' 1
    tinymix 'RX INT0 DEM MUX' 'CLSH_DSM_OUT'
    tinymix 'EAR PA Gain' 'G_6_DB'
    tinymix 'RX0 Digital Volume' 84
}

function disable_ultrasound
{
    echo "disable ultrasound"
    tinymix 'SLIM RX0 MUX' 'ZERO'
    tinymix 'RX INT0_1 MIX1 INP0' 'ZERO'
    tinymix 'SLIMBUS_0_RX Audio Mixer MultiMedia1' 0
    tinymix 'RX INT0 DEM MUX' 'CLSH_DSM_OUT'
    tinymix 'SLIM_0_RX SampleRate' 'KHZ_48'
}

if [ "$1" = "spk" ]; then
    enable_speaker
    filename=/vendor/etc/spk.wav
elif [ "$1" = "rcv" ]; then
    enable_receiver
    filename=/vendor/etc/rcv.wav
elif [ "$1" = "spk_hp" ]; then
    enable_speaker
    filename=/vendor/etc/spk_hp.wav
elif [ "$1" = "us" ]; then
    enable_ultrasound
    filename=/vendor/etc/ultrasound.wav
else
    echo "Usage: playback.sh device; device: spk or rcv or spk_hp or us"
fi

echo "start playing"
tinyplay $filename

if [ "$1" = "spk" ]; then
    disable_speaker
elif [ "$1" = "rcv" ]; then
    disable_receiver
elif [ "$1" = "spk_hp" ]; then
    disable_speaker
elif [ "$1" = "us" ]; then
    disable_ultrasound
fi

exit 0
