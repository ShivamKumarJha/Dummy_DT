stop mi_thermald;
echo 1 > /sys/class/power_supply/battery/input_suspend;
sleep 2

if [ ! -f "/sdcard/cpu_temp.txt" ];then
        echo "begin to record cpu temp"
else
        echo "cpu_temp.txt already exist, regenerate it"
        rm /sdcard/cpu_temp.txt
fi

for i in `ls /sys/class/thermal/ | grep thermal_zone`;
do
        if [ `cat /sys/class/thermal/${i}/type` = "cpu-1-1-usr" ] ; then
                export cpu_usr="/sys/class/thermal/${i}/temp"
        elif [ `cat /sys/class/thermal/${i}/type` = "gpuss-0-usr" ] ; then
                export gpuss_usr="/sys/class/thermal/${i}/temp"
        fi
done

echo -n "sensor8 = " >> /sdcard/cpu_temp.txt;
echo -n `cat $cpu_usr` >> /sdcard/cpu_temp.txt;
echo  ", " >> /sdcard/cpu_temp.txt;
echo -n "sensor15 = " >> /sdcard/cpu_temp.txt;
echo -n `cat $gpuss_usr` >> /sdcard/cpu_temp.txt;
echo ", " >> /sdcard/cpu_temp.txt;

echo 1612800 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq;
echo 1612800 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq;
echo 1612800 > /sys/devices/system/cpu/cpu7/cpufreq/scaling_min_freq;
echo 1612800 > /sys/devices/system/cpu/cpu7/cpufreq/scaling_max_freq;

j=1;
while [ j -le 8 ]
do
	while true; do done &
	j=$j+1;
done

i=1;
while [ i -le 30 ]
do
	i=$i+1;
	sleep 1;
done

echo -n "sensor8 = " >> /sdcard/cpu_temp.txt;
echo -n `cat $cpu_usr` >> /sdcard/cpu_temp.txt;
echo  ", " >> /sdcard/cpu_temp.txt;
echo -n "sensor15 = " >> /sdcard/cpu_temp.txt;
echo -n `cat $gpuss_usr` >> /sdcard/cpu_temp.txt;
echo ", " >> /sdcard/cpu_temp.txt;

start mi_thermald;
echo 0 > /sys/class/power_supply/battery/input_suspend;

pkill sh
