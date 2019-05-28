#!/system/bin/sh
list=(
'com.andromeda.androbench2' 
'com.a1dev.sdbench' 
)

checklist()
{
i=0
while [ $i -ne ${#list[@]} ]
do

	if [ ${list[$i]} = $1 ]; then
		echo 1
		return
	fi	
	((i++))
done

echo 0
return
}

#app=`getprop sys.storage.bchmode`
app=`getprop sys.foregroundapp`
triggered=`getprop vendor.presdbench`
sd_max=`cat sys/class/mmc_host/mmc0/mmc0/max_freq`
#echo "onFgAPP is $app"
result=`checklist $app`

echo $result

#for androbench test UFS seq-read performance
#=================================================================================================
path=/sys/devices/platform/soc/1d84000.ufshc/host0/target0:0:0/0:0:0:0/block/sda/queue/nr_requests
#/sys/devices/platform/soc/1d84000.ufshc/host0/target0\:0\:0/0\:0\:0\:0/block/sda/queue/nr_requests
#echo Path=$path

if [ "$result" == "1" ]; then
	echo 8 > $path
	#cat $path
else
	echo 128 > $path
	#cat $path
fi
#=================================================================================================

if [ "$result" != "0" ] && [ "$triggered" != "1" ]; then

	#save governor before change
	pre_gov=`cat sys/devices/system/cpu/cpu0/cpufreq/scaling_governor`
	setprop vendor.presdbench 1
	setprop vendor.presdbench.gov $pre_gov
	sleep 5

	log -p d -t [ASUS][StorageBench] trigger1
	echo performance > sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
	echo performance > sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
	echo performance > sys/devices/system/cpu/cpu7/cpufreq/scaling_governor
	echo $sd_max > sys/class/mmc_host/mmc0/mmc0/min_freq

	echo performance > /sys/class/devfreq/soc:qcom,cpu0-cpu-llcc-lat/governor
	echo performance > /sys/class/devfreq/soc:qcom,cpu0-cpu-l3-lat/governor
	echo performance > /sys/class/devfreq/soc:qcom,cpu0-llcc-ddr-lat/governor

	echo performance > /sys/class/devfreq/soc:qcom,cpu4-cpu-l3-lat/governor
	echo performance > /sys/class/devfreq/soc:qcom,cpu4-cpu-llcc-lat/governor
	echo performance > /sys/class/devfreq/soc:qcom,cpu4-llcc-ddr-lat/governor
	echo performance > /sys/class/devfreq/soc:qcom,cpu4-cpu-ddr-latfloor/governor
	echo performance > /sys/class/devfreq/soc:qcom,cpu7-cpu-l3-lat/governor
	
	echo Y > /sys/module/lpm_levels/parameters/sleep_disabled

	echo N > /sys/module/lpm_levels/L3/cpu0/rail-pc/idle_enabled
	echo N > /sys/module/lpm_levels/L3/cpu1/rail-pc/idle_enabled
	echo N > /sys/module/lpm_levels/L3/cpu2/rail-pc/idle_enabled
	echo N > /sys/module/lpm_levels/L3/cpu3/rail-pc/idle_enabled
	echo N > /sys/module/lpm_levels/L3/cpu4/rail-pc/idle_enabled
	echo N > /sys/module/lpm_levels/L3/cpu5/rail-pc/idle_enabled
	echo N > /sys/module/lpm_levels/L3/cpu6/rail-pc/idle_enabled
	echo N > /sys/module/lpm_levels/L3/cpu7/rail-pc/idle_enabled
	echo N > /sys/module/lpm_levels/L3/llcc-off/idle_enabled
	echo N > /sys/module/lpm_levels/L3/l3-wfi/idle_enabled

elif [ "$triggered" = "1" ]; then
	#echo 0 > sys/devices/system/cpu/cpufreq/policy0/interactive/io_is_busy
	#echo 0 > sys/devices/system/cpu/cpufreq/policy0/interactive/io_is_busy

	log -p d -t [ASUS][StorageBench] trigger2
	#restore governor after changed
	setprop vendor.presdbench 0
	pre_gov=`getprop vendor.presdbench.gov`

	echo $pre_gov > sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
	echo $pre_gov > sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
	echo $pre_gov > sys/devices/system/cpu/cpu7/cpufreq/scaling_governor
	echo 50000000 > sys/class/mmc_host/mmc0/mmc0/min_freq

	echo mem_latency > /sys/class/devfreq/soc:qcom,cpu0-cpu-llcc-lat/governor
	echo mem_latency > /sys/class/devfreq/soc:qcom,cpu0-cpu-l3-lat/governor
	echo mem_latency > /sys/class/devfreq/soc:qcom,cpu0-llcc-ddr-lat/governor

	echo mem_latency > /sys/class/devfreq/soc:qcom,cpu4-cpu-l3-lat/governor
	echo mem_latency > /sys/class/devfreq/soc:qcom,cpu4-cpu-llcc-lat/governor
	echo mem_latency > /sys/class/devfreq/soc:qcom,cpu4-llcc-ddr-lat/governor
	echo compute > /sys/class/devfreq/soc:qcom,cpu4-cpu-ddr-latfloor/governor
	echo mem_latency > /sys/class/devfreq/soc:qcom,cpu7-cpu-l3-lat/governor
	
	echo N > /sys/module/lpm_levels/parameters/sleep_disabled

	echo Y > /sys/module/lpm_levels/L3/cpu0/rail-pc/idle_enabled
	echo Y > /sys/module/lpm_levels/L3/cpu1/rail-pc/idle_enabled
	echo Y > /sys/module/lpm_levels/L3/cpu2/rail-pc/idle_enabled
	echo Y > /sys/module/lpm_levels/L3/cpu3/rail-pc/idle_enabled
	echo Y > /sys/module/lpm_levels/L3/cpu4/rail-pc/idle_enabled
	echo Y > /sys/module/lpm_levels/L3/cpu5/rail-pc/idle_enabled
	echo Y > /sys/module/lpm_levels/L3/cpu6/rail-pc/idle_enabled
	echo Y > /sys/module/lpm_levels/L3/cpu7/rail-pc/idle_enabled
	echo Y > /sys/module/lpm_levels/L3/llcc-off/idle_enabled
	echo Y > /sys/module/lpm_levels/L3/l3-wfi/idle_enabled
fi
