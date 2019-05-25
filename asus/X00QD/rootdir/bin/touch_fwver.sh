#!/system/bin/sh

fw_ver=$(cat /sys/class/switch/touch/name)

setprop touch.version.driver "$fw_ver"
