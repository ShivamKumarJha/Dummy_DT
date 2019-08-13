#!/vendor/bin/sh
audbg_mode=`getprop persist.vendor.asus.audbg`
is_factory_mode=`getprop ro.boot.pre-ftm`

for i in $(seq 1 120)
do
    audio_codec_status=`cat /proc/driver/audio_codec_status`
    if [ "$audio_codec_status" == "1" -o  "$audio_codec_status" == "0" ]; then
        break
    fi
    sleep 1
done

echo "check audio debug mode $audbg_mode" > /proc/driver/audio_debug

case "$audbg_mode" in
  "0")
    setprop persist.vendor.asus.audbg 0
    ;;
  "1")
    setprop persist.vendor.asus.audbg 1
    ;;
  "")
    if [ "$is_factory_mode" == "1" ]; then
        setprop persist.vendor.asus.audbg 1
    else
        setprop persist.vendor.asus.audbg 0
    fi
    ;;
esac
