#!/vendor/bin/sh

umask 022

Log(){
    log -p d -t modemlog $1
}

# User can config modem log by file "/sdcard/log_cfg/cs.cfg"
# System default config file is "/vendor/etc/cs.cfg".
if [ -e /sdcard/log_cfg/cs.cfg ]; then
    setprop "persist.sys.lenovo.log.qxdmcfg" "/sdcard/log_cfg/cs.cfg"
    Log "setprop persist.sys.lenovo.log.qxdmcfg to /sdcard/log_cfg/cs.cfg"
else
    setprop "persist.sys.lenovo.log.qxdmcfg" "/vendor/etc/cs.cfg"
    Log "setprop persist.sys.lenovo.log.qxdmcfg to /vendor/etc/cs.cfg"
fi

setprop "persist.sys.lenovo.log.path" "/sdcard/log/mdlog"
Log "setprop persist.sys.lenovo.log.path to /sdcard/log/mdlog"

CFGFILE=$(getprop persist.sys.lenovo.log.qxdmcfg)
LOGFILE=$(getprop persist.sys.lenovo.log.path)

Log "start diag_mdlog"
Log "CFGFILE=$CFGFILE"
Log "LOGFILE=$LOGFILE"

#kill the diag_mdlog process at first
/vendor/bin/diag_mdlog -k -c
# -s set the single log size in MB
/vendor/bin/diag_mdlog -s 512 -n 10 -f $CFGFILE -o $LOGFILE

# scripty will hold in the last line, should never come here.
Log "start diag_mdlog done, exit scripty"

