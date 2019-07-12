#!/vendor/bin/sh

notice()
{
	echo "$*"
	echo "$scriptname: $*" > /dev/kmsg
}

path=/vendor/etc/acdbdata
device=common
# For ocean NA sku, use seprate parameter files.
if [ "`getprop ro.vendor.hw.radio`" == "NA" ]
then
	device=na
fi

index=0
for file in $(ls $path/$device/); do
    setprop persist.vendor.audio.calfile$index $path/$device/$file
    index=$((index+1))
done
notice "hw.radio: [`getprop ro.vendor.hw.radio`], calfile6: [`getprop persist.vendor.audio.calfile6`]"
