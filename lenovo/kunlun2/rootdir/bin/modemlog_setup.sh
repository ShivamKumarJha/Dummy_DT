#!/vendor/bin/sh

# start modem offline log

mdmlog_stat="stopped"
enable_mdm_log=0

Log(){
    log -p d -t modemlog_setup $1
}

# We do not start modem log in user version when system boot.
user=`cat /system/etc/version.conf | grep USER | grep -v -c BLC`
if [ $user -gt 0]; then
    echo "this is a user version"
    exit
fi

# Check modemlog.enable file,
# if file exist, set enable_mdm_log to 1
if [ "$enable_mdm_log" == "0" ]; then
    for i in $(seq 0 9)
    do
        if [ $(getprop persist.sys.aplog.modemlog) = "true" ]; then
            enable_mdm_log=1
            Log "find file modemlog.enable"
            break
        else
            sleep 1
        fi
    done
fi

# If enable_mdm_log == 1, start modem log
if [ "$enable_mdm_log" == "1" ]; then
    Log "try to start modem offline log"

    setprop "ctl.start" modemlog

fi

