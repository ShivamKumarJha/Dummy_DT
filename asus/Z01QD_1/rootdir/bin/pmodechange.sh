#!/system/vendor/bin/sh

echo 1 > /sys/fs/selinux/log
pmode=`getprop sys.foregroundapp`

if [ "$pmode" == "tw.com.joybomb.pi2017" ]; then
	setprop sys.cpu.pmodeset 1

	echo N > /sys/module/lpm_levels/L3/cpu0/rail-pc/idle_enabled
	echo N > /sys/module/lpm_levels/L3/cpu1/rail-pc/idle_enabled
	echo N > /sys/module/lpm_levels/L3/cpu2/rail-pc/idle_enabled
	echo N > /sys/module/lpm_levels/L3/cpu3/rail-pc/idle_enabled
	echo N > /sys/module/lpm_levels/L3/cpu4/rail-pc/idle_enabled
	echo N > /sys/module/lpm_levels/L3/cpu5/rail-pc/idle_enabled
	echo N > /sys/module/lpm_levels/L3/cpu6/rail-pc/idle_enabled
	echo N > /sys/module/lpm_levels/L3/cpu7/rail-pc/idle_enabled

	echo N > /sys/module/lpm_levels/L3/cpu0/pc/idle_enabled
	echo N > /sys/module/lpm_levels/L3/cpu1/pc/idle_enabled
	echo N > /sys/module/lpm_levels/L3/cpu2/pc/idle_enabled
	echo N > /sys/module/lpm_levels/L3/cpu3/pc/idle_enabled
	echo N > /sys/module/lpm_levels/L3/cpu4/pc/idle_enabled
	echo N > /sys/module/lpm_levels/L3/cpu5/pc/idle_enabled
	echo N > /sys/module/lpm_levels/L3/cpu6/pc/idle_enabled
	echo N > /sys/module/lpm_levels/L3/cpu7/pc/idle_enabled
else
	pmodeset=`getprop sys.cpu.pmodeset`

	if [ "$pmodeset" == "1" ]; then
		setprop sys.cpu.pmodeset 0
	
		echo Y > /sys/module/lpm_levels/L3/cpu0/rail-pc/idle_enabled
		echo Y > /sys/module/lpm_levels/L3/cpu1/rail-pc/idle_enabled
		echo Y > /sys/module/lpm_levels/L3/cpu2/rail-pc/idle_enabled
		echo Y > /sys/module/lpm_levels/L3/cpu3/rail-pc/idle_enabled
		echo Y > /sys/module/lpm_levels/L3/cpu4/rail-pc/idle_enabled
		echo Y > /sys/module/lpm_levels/L3/cpu5/rail-pc/idle_enabled
		echo Y > /sys/module/lpm_levels/L3/cpu6/rail-pc/idle_enabled
		echo Y > /sys/module/lpm_levels/L3/cpu7/rail-pc/idle_enabled

		echo Y > /sys/module/lpm_levels/L3/cpu0/pc/idle_enabled
		echo Y > /sys/module/lpm_levels/L3/cpu1/pc/idle_enabled
		echo Y > /sys/module/lpm_levels/L3/cpu2/pc/idle_enabled
		echo Y > /sys/module/lpm_levels/L3/cpu3/pc/idle_enabled
		echo Y > /sys/module/lpm_levels/L3/cpu4/pc/idle_enabled
		echo Y > /sys/module/lpm_levels/L3/cpu5/pc/idle_enabled
		echo Y > /sys/module/lpm_levels/L3/cpu6/pc/idle_enabled
		echo Y > /sys/module/lpm_levels/L3/cpu7/pc/idle_enabled
	fi
fi
echo 0 > /sys/fs/selinux/log
