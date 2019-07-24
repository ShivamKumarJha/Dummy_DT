#!/vendor/bin/sh
rm -rf /sdcard/qmlog.txt
rm -rf /sdcard/qmesa_stop
rm -rf /sdcard/qmesa_cpu_count
sed -n '/^processor/p' /proc/cpuinfo | while read -r line
do
    cpuCount=$(echo "$line" | cut -d ':' -f 2)
    echo "$cpuCount" > /sdcard/qmesa_cpu_count
done
cpuCount=$(sed -n 's/[[:space:]]//gp' /sdcard/qmesa_cpu_count)
if [ "$cpuCount" == "0" ] || [ "$cpuCount" == "" ]
then
   echo "cpu count error" >>  /sdcard/qmlog.txt
   echo "stop" &>> /sdcard/qmesa_stop
   exit 1
fi
time=10000
if [ -e "/sdcard/qmtime" ]
then
    time=$(cat /sdcard/qmtime)
else
    echo "use default time, 10000 secs" >> /sdcard/qmlog.txt
fi
echo "/vendor/bin/QMESA_64 -startSize 32MB -endSize 64MB -totalSize 64MB -errorCheck T -secs $time -numThreads $cpuCount &>> /sdcard/qmlog.txt" >> /sdcard/qmlog.txt
/vendor/bin/QMESA_64 -startSize 32MB -endSize 64MB -totalSize 64MB -errorCheck T -secs "$time" -numThreads "$cpuCount" &>> /sdcard/qmlog.txt
echo "stop" &>> /sdcard/qmesa_stop
exit 0
