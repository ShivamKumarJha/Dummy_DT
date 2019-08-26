#!/vendor/bin/sh

vendor=$(getprop persist.vendor.battery.charge)
if [ -z $vendor ]; then
	$(setprop vendor.battery.charge.osv.init 1)
fi
