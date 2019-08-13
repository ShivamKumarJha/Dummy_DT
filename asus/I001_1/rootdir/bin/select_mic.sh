#!/vendor/bin/sh
if [ "$1" -ge 0 ] && [ "$1" -le 5 ]; then
    setprop vendor.audio.mic.selected $1
    result=`getprop vendor.audio.mic.selected`
    if [ "$result" == "$1" ]; then
        echo 1
    else
        echo 0
    fi
else
    echo 0
fi
