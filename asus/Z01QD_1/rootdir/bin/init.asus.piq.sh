#!/system/bin/sh

build_type=`getprop ro.build.type`
logupload=`getprop persist.asus.autoupload.enable`
android_boot=`getprop sys.boot_completed`
is_factory=`getprop ro.boot.ftm`

if [ ".$build_type" == ".userdebug" ]; then
   if [ ".$is_factory" != ".1" ]; then
#      am broadcast -a "com.mybroadcast.action.myBootComplete"
   fi
else
   #if [ ".$logupload" == ".1" ]; then
#      am broadcast -a "com.mybroadcast.action.myBootComplete"
   #fi
fi
