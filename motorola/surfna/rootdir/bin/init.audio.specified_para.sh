#!/vendor/bin/sh

notice()
{
	echo "$*"
	echo "$scriptname: $*" > /dev/kmsg
}

path=/vendor/etc/acdbdata
device=common

na_radios="NA NA_TMO NA_SPRINT"
typeset -u radio=$(getprop ro.vendor.hw.radio)

if echo "$na_radios" | /vendor/bin/toybox_vendor grep -w "$radio" &>/dev/null; then
	device=na
fi

index=0
for file in $(ls $path/$device/); do
    setprop persist.vendor.audio.calfile$index $path/$device/$file
    index=$((index+1))
done
notice "hw.radio: [`getprop ro.vendor.hw.radio`], calfile6: [`getprop persist.vendor.audio.calfile6`]"
