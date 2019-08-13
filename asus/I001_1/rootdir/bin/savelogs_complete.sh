#!/system/bin/sh
uts=`getprop persist.asus.uts`
am broadcast -a $uts -n com.asus.loguploader/.logtool.LogtoolReceiver
