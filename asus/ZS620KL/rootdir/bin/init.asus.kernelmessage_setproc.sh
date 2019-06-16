#!/system/bin/sh
kernelmessage_mode=`getprop persist.asus.kernelmessage`
if [ ".$kernelmessage_mode" == ".0" ];then
		echo 0 > /proc/asusklog
elif [ ".$kernelmessage_mode" == ".7" ];then
		echo 1 > /proc/asusklog
else
	echo "error persist.asus.kernelmessage"
fi
