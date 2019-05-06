export PATH=/vendor/bin

################################################################
# Usage:
# xxx-restart-counter-sh /vendor/bin/sh init.vivo.fingerprint_restart_counter.sh biometrics-fingerprint-xxx #max_restart_times

reboot_times=`getprop sys.fingerprint.reboottimes`
if [ -z "$reboot_times" ]; then
    reboot_times=0
fi

# default max restart times is 5.
max_restart_times=5
if [ -n $2 ]; then
    max_restart_times=$2
fi

let "max_restart_times = max_restart_times + 0"

let "reboot_times++"
if [ $reboot_times -gt $max_restart_times ]; then
    # ctl property set in this shell need qti_init_shell
    # has "ctl_default_prop:property_service set" permission
    # in qcom platform.
    setprop ctl.stop $1
else
    setprop sys.fingerprint.reboottimes "$reboot_times"
    #setprop ctl.start $1
fi
