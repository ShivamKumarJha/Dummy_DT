#!/vendor/bin/sh
echo "acdb_path"
typeset -l carrier=$(getprop ro.carrier)

if [ $carrier == "amxbr" ] || [ $carrier == "tefbr" ] || [ $carrier == "timbr" ] || [ $carrier == "retbr" ]; then
# use audio parameter specialized for brazil
path=/vendor/etc/acdbdata/brazil
else
# use default audio parameter
path=/vendor/etc/acdbdata/common
fi

index=0
for file in $(ls $path/*.acdb); do
    setprop persist.vendor.audio.calfile$index $file
    index=$((index+1))
done

