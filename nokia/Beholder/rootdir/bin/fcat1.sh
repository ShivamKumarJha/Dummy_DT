status=0
mkdir -p /sdcard/DCIM/fcat1/

touch /sdcard/DCIM/fcat1/kmsg.log
nohup logcat &> /sdcard/DCIM/fcat1/logcat.log &
while true; do nohup dmesg -c &> /sdcard/DCIM/fcat1/kmsg.log; done & 

./fcat_utility -V -t &> /sdcard/DCIM/fcat1/log_tof.txt
status=$((status+$?))
./fcat_utility -V -f &> /sdcard/DCIM/fcat1/log_flash.txt
status=$((status+$?))
./fcat_utility -V -c &> /sdcard/DCIM/fcat1/log_vcm.txt
status=$((status+$?))
./fcat_utility -V -e &> /sdcard/DCIM/fcat1/log_eeprom.txt
status=$((status+$?))
./fcat_utility -V -2 &> /sdcard/DCIM/fcat1/log_i2c_test.txt
status=$((status+$?))
./fcat_utility -V -g &> /sdcard/DCIM/fcat1/log_gyro.txt
status=$((status+$?))
./fcat_utility -V -i &> /sdcard/DCIM/fcat1/log_mipi.txt
status=$((status+$?))

kill $(ps | grep logcat | busybox awk '{ print $2 }')
dmesg_done=$(killall -SIGKILL dmesg)
while [[ dmesg_done -ne 0 ]]  
do
    dmesg_done=$(killall -SIGKILL dmesg)
done

return $status




