#!/vendor/bin/sh
echo "acdb_path"
typeset -l carrier=$(getprop ro.carrier)

if [ $carrier == "retid" ]; then
# use audio parameter specialized for indonesia 
path=/vendor/etc/acdbdata/idn
else
# use default audio parameter
path=/vendor/etc/acdbdata/common
fi

index=0
for file in $(ls $path/*.acdb); do
    setprop persist.vendor.audio.calfile$index $file
    index=$((index+1))
done

