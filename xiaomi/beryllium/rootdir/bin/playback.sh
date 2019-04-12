# $1: wave file to read
# $2: device for output
#     0: current
#     1: speaker
#     2: receiver
#     9: ultrasound transducer

# tinyplay file.wav [-D card] [-d device] [-p period_size] [-n n_periods]
# sample usage: playback.sh 2000.wav  1
# RCV: L    SPK: R
# ultrasound :  0dBFS input , must decrease 3db in codec, to make sure V_mutata<= 6p-p
# spk.wav rcv_hp.wav : -7.7dbfs   rcv.wav : -14.7dbfs  ultrasound : 0dbfs

function enable_receiver
{
        echo "enabling receiver"
        tinymix 'QUAT_MI2S_RX Audio Mixer MultiMedia1' 1
        tinymix 'QUAT_MI2S_RX Channels' 'Two'
        tinymix 'QUAT_MI2S_RX SampleRate' 'KHZ_96'
        tinymix 'Program' 1
        sleep 1
        tinymix 'TAS2559 DAC Playback Volume' 15
        tinymix 'TAS2560 DAC Playback Volume' 0
}

function disable_receiver
{
        echo "disabling receiver"
        tinymix 'Program' 0
        tinymix 'TAS2559 DAC Playback Volume' 15
        tinymix 'TAS2560 DAC Playback Volume' 15
        tinymix 'QUAT_MI2S_RX Channels' 'Two'
        tinymix 'QUAT_MI2S_RX SampleRate' 'KHZ_48'
        tinymix 'QUAT_MI2S_RX Audio Mixer MultiMedia1' 0
}

function enable_speaker
{
        echo "enabling speaker"
        tinymix 'QUAT_MI2S_RX Audio Mixer MultiMedia1' 1
        tinymix 'QUAT_MI2S_RX Channels' 'Two'
        tinymix 'Program' 2
        tinymix 'Configuration' 11
        sleep 1
        tinymix 'TAS2559 DAC Playback Volume' 0
        tinymix 'TAS2560 DAC Playback Volume' 15
}

function disable_speaker
{
        echo "disabling speaker"
        tinymix 'Program' 0
        tinymix 'TAS2559 DAC Playback Volume' 15
        tinymix 'TAS2560 DAC Playback Volume' 15
        tinymix 'QUAT_MI2S_RX Channels' 'Two'
        tinymix 'QUAT_MI2S_RX Audio Mixer MultiMedia1' 0
}

function enable_ultrasound_transducer
{
        echo "enabling ultrasound transducer"
        tinymix 'SLIMBUS_0_RX Audio Mixer MultiMedia1' 1
        tinymix 'SLIM RX0 MUX' 'AIF1_PB'
        tinymix 'SLIM_0_RX Channels' 'One'
        tinymix 'SLIM_0_RX SampleRate' 'KHZ_96'
        tinymix 'CDC_IF RX0 MUX' 'SLIM RX0'
        tinymix 'RX INT4_2 MUX' 'RX0'
        tinymix 'RX4 Mix Digital Volume' 84
        tinymix 'LINEOUT2 Volume' 13
        tinymix 'Ultrasound Power' 'On'
}

function disable_ultrasound_transducer
{
        echo "disabling ultrasound transducer"
        tinymix 'SLIMBUS_0_RX Audio Mixer MultiMedia1' 0
        tinymix 'SLIM_0_RX SampleRate' 'KHZ_48'
        tinymix 'SLIM RX0 MUX' 'ZERO'
        tinymix 'RX INT4_1 MIX1 INP0' 'ZERO'
        tinymix 'Ultrasound Power' 'Off'
}


if [ "$2" -eq "1" ]; then
	enable_speaker
elif [ "$2" -eq "2" ]; then
	enable_receiver
elif [ "$2" -eq "9" ]; then
        enable_ultrasound_transducer
fi


echo "start playing"
tinyplay $1

if [ "$2" -eq "1" ]; then
	disable_speaker
elif [ "$2" -eq "2" ]; then
	disable_receiver
elif [ "$2" -eq "9" ]; then
        disable_ultrasound_transducer
fi


exit 0
