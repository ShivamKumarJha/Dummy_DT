#!/system/bin/sh

LOG_TAG="simcode"
file="/vendor/factory/SIMCODE"
PROPERTY="persist.radio.multisim.config"

if test -f $file ; then
   SIMCODE=`cat $file`
    if [[ "$SIMCODE" == "s1" || "$SIMCODE" == "S1" ]] ; then
        setprop $PROPERTY none
    elif [[ "$SIMCODE" == "s2" || "$SIMCODE" == "S2" ]] ; then
        setprop $PROPERTY dsds
    fi
fi

## Set AMAX tty, hac property
country=`getprop ro.config.versatility`
if [ "$country" == "US" ]; then
    setprop ro.vendor.asus.phone.hac 1
    setprop ro.vendor.asus.phone.tty 1
fi


# set cid property that rild can read.
cid=`getprop ro.config.CID`
setprop ro.vendor.asus.phone.cid $cid

