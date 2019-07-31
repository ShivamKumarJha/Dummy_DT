#!/vendor/bin/sh

# Add by wangwq14, start to record battery log.

umask 022

if [ -d /data/vendor/newlog/aplog ]; then
	APLOG_DIR=/data/vendor/newlog/aplog
else
	APLOG_DIR=/data/local/newlog/aplog
fi

BATT_LOGSHELL="/vendor/bin/batterylog.sh"
BATT_LOGFILE=${APLOG_DIR}"/batterylog"
BATT_LOGFILE_QC=${APLOG_DIR}"/batterylog.qc"
BATT_LOGFILE_GROUP_MAX_SIZE=20971520

# mv files.x-1 to files.x
mv_files()
{
    if [ -z "$1" ]; then
      echo "No file name!"
      return
    fi

    if [ -z "$2" ]; then
      fileNum=$(getprop persist.sys.aplogfiles)
      if [ $fileNum -gt 0 ]; then
        LAST_FILE=$fileNum
      else
        LAST_FILE=5
      fi
    else
      LAST_FILE=$2
    fi

    i=$LAST_FILE
    while [ $i -gt 0 ]; do
      prev=$(($i-1))
      if [ -e "$1.$prev" ]; then
        mv $1.$prev $1.$i
      fi
      i=$(($i-1))
    done

    if [ -e $1 ]; then
      mv $1 $1.1
    fi
}

file_count=0
count=1
prop_len=0
pause_time=10
dumper_en=1

mv_files $BATT_LOGFILE
if [ $dumper_en -eq 1 ]; then
    mv_files $BATT_LOGFILE_QC
fi

while [ 1 ]
do
    utime=($(cat /proc/uptime))
    ktime=${utime[0]}

    if [ $(((count - 1) % 5)) -eq 0 ]; then
        dumper_flag=1
    else
        dumper_flag=0
    fi

    #      0              1                                  2        3             4          5            6           7           8      9
    buf=`. $BATT_LOGSHELL "$(date "+%Y-%m-%d %H:%M:%S.%3N")" ${ktime} $BATT_LOGFILE $dumper_en $dumper_flag "$prop_len" $file_count $count $pause_time`

    buf=`echo ${buf##*prop_len=\[}`
    prop_len=`echo ${buf%\]=prop_len*}`

    BATT_LOGFILE_size=`stat -c "%s" $BATT_LOGFILE`
    if [ $dumper_en -eq 1 ]; then
        BATT_LOGFILE_QC_size=`stat -c "%s" $BATT_LOGFILE_QC`
    else
        BATT_LOGFILE_QC_size=0
    fi
    BATT_LOGFILE_GROUP_size=$(($BATT_LOGFILE_size+$BATT_LOGFILE_QC_size))

    let count=$count+1
    sleep $pause_time

    if [ $BATT_LOGFILE_GROUP_size -gt $BATT_LOGFILE_GROUP_MAX_SIZE ]; then
        mv_files $BATT_LOGFILE
        if [ $dumper_en -eq 1 ]; then
            mv_files $BATT_LOGFILE_QC
        fi
        let file_count=$file_count+1
    fi
done

