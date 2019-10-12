#!/vendor/bin/sh

main_sound_card=`/vendor/bin/cat /proc/asound/cards| /vendor/bin/grep "sdm660tashasndc"| /vendor/bin/sed 's/ /\t/g'| /vendor/bin/cut -f 2`
/system/bin/tinymix -D ${main_sound_card} 'TERT_MI2S_RX Audio Mixer MultiMedia1' 1 > /dev/null 2>&1
/system/bin/tinyplay /vendor/etc/silence_48k-samplerate.wav -D ${main_sound_card} > /dev/null 2>&1 &
/vendor/bin/sleep 2 > /dev/null 2>&1
/system/bin/tinymix -D ${main_sound_card} 'TERT_MI2S_RX Audio Mixer MultiMedia1' 0 > /dev/null 2>&1
/vendor/bin/killall -9 /system/bin/tinyplay > /dev/null 2>&1

