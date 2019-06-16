#!/system/bin/sh
asusinov_mode=`getprop persist.asus.test.inov`
if [ ".$asusinov_mode" == ".0" ];then
		echo 1 > /proc/driver/charger_inov_enable
elif [ ".$asusinov_mode" == ".1" ];then
		echo 0 > /proc/driver/charger_inov_enable
else
	echo "error persist.asus.test.inov and etc."
fi
