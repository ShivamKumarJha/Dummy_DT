#!/vendor/bin/sh
export PATH=/vendor/bin

#ASUS_BSP +++ Shawn_Huang slpi ssr
echo adsp_ssr > /sys/power/wake_lock
sns_dump_pm
sns_dump_request
stop adsprpcd
sns_restart
sleep 5
start adsprpcd
sleep 1
stop audioserver
sleep 1
start audioserver
setprop sys.asus.ssc.reset 0
echo adsp_ssr > /sys/power/wake_unlock
#ASUS_BSP --- Shawn_Huang slpi ssr
