export PATH=/vendor/bin

# Usage
# service /vendor/bin/sh init.vivo.fingerprint_restart_counter.sh $fingerprintd #max_restart_times

reboot_times=`getprop sys.fingerprint.reboottimes`
if [ -z "$reboot_times" ]; then
    reboot_times=0
fi

max_restart_times=5
if [ -n $2 ]; then
    max_restart_times=$2
fi

let "max_restart_times = max_restart_times + 0"

let "reboot_times++"
if [ $reboot_times -gt $max_restart_times ]; then
    setprop sys.fingerprint.stop $1
else
    setprop sys.fingerprint.restart $1
    setprop sys.fingerprint.reboottimes "$reboot_times"
fi
