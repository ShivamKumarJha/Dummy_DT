#!/system/bin/sh
# dump_sniffer.sh

cp -f $(getprop vendor.wlan.sniffer.vendor_file) $(getprop vendor.wlan.sniffer.output_file)
setprop vendor.wlan.sniffer.dump 0