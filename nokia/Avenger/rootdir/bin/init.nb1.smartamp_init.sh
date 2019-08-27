#!/vendor/bin/sh

for COUNT in 1 2 3 4 5 6 7 8 9 10;
do
    flag0=($(cat /proc/asound/card0/id));
    if [ "$flag0" = "msm8998tashasnd" ];then
        break
    else
        sleep 0.3
    fi
done

if [ "$flag0" = "msm8998tashasnd" ];then
    main_sound_card=0
else
    main_sound_card=1
fi

/system/bin/tinymix -D ${main_sound_card} 'QUAT_MI2S_RX Audio Mixer MultiMedia5' 1  > /dev/null 2>&1
/system/bin/tinyplay /vendor/etc/audio/silence_48k.wav -D $main_sound_card  -d 13  > /dev/null 2>&1 &
TINYPLAY_PID=$!> /dev/null 2>&1
sleep 2
kill $TINYPLAY_PID > /dev/null 2>&1
sleep 0.1
/system/bin/tinymix -D $main_sound_card  'QUAT_MI2S_RX Audio Mixer MultiMedia5' 0  > /dev/null 2>&1