#!/vendor/bin/sh

umask 022
APLOG_DIR=/data/vendor/newlog/aplog

TZ_LOGFILE=${APLOG_DIR}"/tzlog"

QSEE_LOGFILE=${APLOG_DIR}"/qseelog"
QSEE_LOGFILE_MAX_SIZE=5242880

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

mv_files $TZ_LOGFILE
mv_files $QSEE_LOGFILE

while [ 1 ]
do
    date >> $QSEE_LOGFILE
    echo "" >> $QSEE_LOGFILE
    cat /d/tzdbg/qsee_log >> $QSEE_LOGFILE
    QSEE_LOGFILE_size=`stat -c "%s" $QSEE_LOGFILE`
    if [ $QSEE_LOGFILE_size -gt $QSEE_LOGFILE_MAX_SIZE ]; then
        mv_files $QSEE_LOGFILE
    fi

    date >> $TZ_LOGFILE
    echo "" >> $TZ_LOGFILE
    cat /d/tzdbg/log >> $TZ_LOGFILE

    sleep 2
done

