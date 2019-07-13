#!/vendor/bin/sh
echo "acdb_path"
typeset -l carrier=$(getprop ro.carrier)

brazil="timbr tefbr amxbr retbr"

if echo "${brazil[@]}" | /vendor/bin/toybox_vendor grep -w "$carrier" &>/dev/null; then
# use audio parameter specialized for Brazilian market
path=/vendor/etc/acdbdata_bl
elif [ $carrier == "retid" ]; then
# use audio parameter specialized for indonesia 
path=/vendor/etc/acdbdata_id
else
# use default audio parameter
path=/vendor/etc/acdbdata 
fi

index=0
for file in $(ls $path/*.acdb); do
    setprop persist.vendor.audio.calfile$index $file
    index=$((index+1))
done

