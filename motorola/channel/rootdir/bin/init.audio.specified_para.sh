#!/vendor/bin/sh

notice()
{
	echo "$*"
	echo "$scriptname: $*" > /dev/kmsg
}

typeset -l carrier=$(getprop ro.carrier)
brazil="timbr tefbr amxbr retbr"

path=/vendor/etc/acdbdata
device=common

if [ "`getprop ro.vendor.hw.hwrev`" == "0xC000" -o "`getprop ro.vendor.hw.hwrev`" == "0xCB00" ]
then
    Smartpa=true
else
    Smartpa=false
fi

# use audio parameter specialized for Brazilian market
if echo "${brazil[@]}" | /vendor/bin/toybox_vendor grep -w "$carrier" &>/dev/null; then
	Braz=true
else
	Braz=false
fi

# For channel NA sku, use seprate parameter files.
if [[ "`getprop ro.vendor.hw.radio`" == *"NA"* ]]
then
	device=na
elif [ "$Smartpa" == "true" ]&&[ "$Braz" == "true" ]
then
	device=bl_s
elif [ "$Smartpa" == "false" ]&&[ "$Braz" == "true" ]
then
	device=bl
elif [ "$Smartpa" == "true" ]&&[ "$Braz" == "false" ]
then
	device=common_s
else
	device=common
fi
notice "Smartpa = $Smartpa,Braz = $Braz: device = $device"
index=0
for file in $(ls $path/$device/); do
    setprop persist.vendor.audio.calfile$index $path/$device/$file
    index=$((index+1))
done
notice "hw.radio: [`getprop ro.vendor.hw.radio`], calfile6: [`getprop persist.vendor.audio.calfile6`]"
