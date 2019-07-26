#!/system/bin/sh

#ASUS_BSP+++ [ZEUS][USB][NA][FIX] Support setting SSN dynamically in FTM mode
serialno=`cat /vendor/SSN`
echo "[usb] Set SSN dynamically start" > /dev/kmsg

if [ "$serialno" == "" ]; then
    serialno=111111111111111
fi

echo $serialno > /config/usb_gadget/g1/strings/0x409/serialnumber
#ASUS_BSP--- [ZEUS][USB][NA][FIX] Support setting SSN dynamically in FTM mode
