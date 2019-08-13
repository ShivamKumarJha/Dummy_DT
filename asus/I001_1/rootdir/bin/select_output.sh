#!/vendor/bin/sh
if [ "$1" -ge 0 ] && [ "$1" -le 7 ]; then
    setprop vendor.audio.output.selected $1
    result=`getprop vendor.audio.output.selected`
    if [ "$result" == "$1" ]; then
        echo 1
    else
        echo 0
    fi
else
    echo 0
fi
