#!/system/bin/sh
uts=`getprop persist.asus.uts`
am broadcast -a $uts
