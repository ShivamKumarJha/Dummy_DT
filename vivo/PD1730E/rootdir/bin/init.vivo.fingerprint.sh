export PATH=/vendor/bin

if [ -f /sys/fp_id/fp_id ]; then
    fp_module=`cat /sys/fp_id/fp_id` 2> /dev/null
    setprop persist.sys.fptype "$fp_module"
    setprop sys.fingerprint.boot "$fp_module"
    isUD=`echo "$fp_module" | grep "^udfp_"`
    if [ "$isUD" != "" ];then
        setprop persist.vivo.fingerprint.front "true"
    fi
fi
