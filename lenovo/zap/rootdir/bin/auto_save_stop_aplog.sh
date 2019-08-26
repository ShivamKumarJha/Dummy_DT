#!/vendor/bin/sh

# Add by wangwq14
# This shell will record logs to aplog dir.
# This shell will run when system first boot, such as after qfile burn, factoryreset, OTA.
# This shell is related to aplog.sh,  copy_aplog.sh, init.xuilog.rc.
# This shell will record it history to file /data/vendor/newlog/aplog/auto_save_stop_aplog.history.
# history: 2016-12-02, wwqing14, initial version

LOGFILE=/data/vendor/newlog/aplog/auto_save_stop_aplog.history
MAIN_LOG_STATUS=stopped
KERNEL_LOG_STATUS=stopped
QSEE_LOG_STATUS=stopped
LOG_STATUS_CHANGED=no

mkdir -p /data/vendor/newlog/aplog
date  > $LOGFILE
echo "mkdir /data/vendor/newlog/aplog done" >> $LOGFILE
echo "" >> $LOGFILE

if [ -n "$(getprop persist.vendor.firstbootfinish)" ]; then
  if [ $(getprop persist.vendor.firstbootfinish) = 1 ]; then
    echo "persist.vendor.firstbootfinish is 1, exit." >> $LOGFILE
    return
  fi
else
  echo "persist.vendor.firstbootfinish is not set, set to default value 1" >> $LOGFILE
  setprop persist.vendor.firstbootfinish 1
fi

for i in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30;
do
  echo "xxx This is $i times test "
  date  >> $LOGFILE

  # log service which should be started by aplog.sh
  if [ -n "$(getprop init.svc.mainlog)" ]; then
    if [ $(getprop init.svc.mainlog) = "running" ]; then
      echo "mainlog is running." >> $LOGFILE
      MAIN_LOG_STATUS=running
    else
      echo "mainlog is stopped" >> $LOGFILE
      MAIN_LOG_STATUS=stopped
    fi
  else
    echo "mainlog not run" >> $LOGFILE
    MAIN_LOG_STATUS=stopped
  fi

  if [ -n "$(getprop init.svc.kernellog)" ]; then
    if [ $(getprop init.svc.kernellog) = "running" ]; then
      echo "kernellog is running." >> $LOGFILE
      KERNEL_LOG_STATUS=running
    else
      echo "kernellog is stopped" >> $LOGFILE
      KERNEL_LOG_STATUS=stopped
    fi
  else
    echo "kernellog not run" >> $LOGFILE
    KERNEL_LOG_STATUS=stopped
  fi


  if [ "$MAIN_LOG_STATUS" = "stopped" ]; then
    echo "mainlog services stopped, return shell right now." >> $LOGFILE
    return
  fi

  if [ "$KERNEL_LOG_STATUS" = "stopped" ]; then
    echo "kernellog services stopped, return shell right now." >> $LOGFILE
    return
  fi

  for svc in batterylog mainlog_big radiolog radiolog_big eventslog eventslog_big;
  do
    if [ -n "$(getprop init.svc.$svc)" ]; then
      if [ $(getprop init.svc.$svc) = "running" ]; then
       echo "$svc is running." >> $LOGFILE
       LOG_STATUS_CHANGED=yes
      fi
    else
      echo "$svc not run" >> $LOGFILE
    fi
  done

  if [ "$LOG_STATUS_CHANGED" = "yes" ]; then
    echo "log services changed by 3333 or feedback, return shell right now." >> $LOGFILE
    return
  fi

  echo "sleep 10 seconds ..." >> $LOGFILE
  echo  "" >> $LOGFILE
  sleep 10
done

date  >> $LOGFILE
stop mainlog
echo "mainlog stopped by timeout" >> $LOGFILE
stop kernellog
echo "kernellog stopped by timeout" >> $LOGFILE
echo "" >> $LOGFILE
wait

date  >> $LOGFILE
echo "auto_save_stop_aplog finish. Bye-Bye" >> $LOGFILE
