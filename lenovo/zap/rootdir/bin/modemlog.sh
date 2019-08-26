#!/vendor/bin/sh

umask 022

Log(){
    log -p d -t modemlog $1
}

# User can config modem log by file "/sdcard/log_cfg/cs.cfg"
# System default config file is "/vendor/etc/cs.cfg".
if [ -e /data/vendor/newlog/cs.cfg ]; then
#    setprop "persist.sys.lenovo.log.qxdmcfg" "/sdcard/log_cfg/cs.cfg"
    CFGFILE=/data/vendor/newlog/cs.cfg
    Log "[diag] setprop persist.sys.lenovo.log.qxdmcfg to /data/vendor/newlog/cs.cfg"
else
#    setprop "persist.sys.lenovo.log.qxdmcfg" "/vendor/etc/cs.cfg"
    CFGFILE=/vendor/etc/cs.cfg
    Log "[diag] setprop persist.sys.lenovo.log.qxdmcfg to /vendor/etc/cs.cfg"
fi
LOGFILE=/data/vendor/diag_mdlog
#setprop "persist.sys.lenovo.log.path" "/sdcard/log/mdlog"
Log "[diag] setprop persist.sys.lenovo.log.path to /data/vendor/diag_mdlog"

#CFGFILE=$(getprop persist.sys.lenovo.log.qxdmcfg)
#LOGFILE=$(getprop persist.sys.lenovo.log.path)

Log "start diag_mdlog"
Log "[diag] CFGFILE=$CFGFILE"
Log "[diag] LOGFILE=$LOGFILE"

#kill the diag_mdlog process at first
/vendor/bin/diag_mdlog -k -c
# -s set the single log size in MB
/vendor/bin/diag_mdlog -s 512 -n 10 -f $CFGFILE -o $LOGFILE

# scripty will hold in the last line, should never come here.
Log "[diag] start diag_mdlog done, exit scripty"

