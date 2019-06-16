#!/system/bin/sh
audbg_mode=`getprop persist.asus.audbg`
if [ ".$audbg_mode" == ".0" ];then
		setprop sys.config.uartlog 0
		echo 0 > /proc/driver/audio_debug
elif [ ".$audbg_mode" == ".1" ];then
		setprop sys.config.uartlog 1
		echo 1 > /proc/driver/audio_debug
else
	echo "error persist.asus.audbg"
fi
