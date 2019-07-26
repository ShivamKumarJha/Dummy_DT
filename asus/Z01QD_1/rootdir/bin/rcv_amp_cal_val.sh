#!/vendor/bin/sh

if [ "$1" == "0" ]; then
    AudioAmpCalibration -r 0
else
    echo "Invaild argument"
fi
