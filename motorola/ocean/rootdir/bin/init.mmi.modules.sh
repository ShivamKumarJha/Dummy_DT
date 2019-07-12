#!/vendor/bin/sh

# All modules that depend on conditions or need extra parameters
# should go here.

# Handle factory bootmode
bootmode=$(getprop ro.bootmode)
if [ $bootmode = "mot-factory" ]; then
	insmod /vendor/lib/modules/moto_f_usbnet.ko
fi
