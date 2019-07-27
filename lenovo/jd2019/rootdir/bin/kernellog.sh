#!/vendor/bin/sh

umask 022

APLOG_DIR=/data/vendor/newlog/aplog

KERNEL_LOGFILE=${APLOG_DIR}"/kernellog"
KERNEL_LOGFILE_MAX_SIZE=104857600

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
        LAST_FILE=20
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

mv_files $KERNEL_LOGFILE

while [ 1 ]
do
    date  >> $KERNEL_LOGFILE
    dmesg -c >> $KERNEL_LOGFILE
    echo "" >> $KERNEL_LOGFILE
    LOGFILE_size=`stat -c "%s" $KERNEL_LOGFILE`
    if [ $LOGFILE_size -gt $KERNEL_LOGFILE_MAX_SIZE ]; then
        mv_files $KERNEL_LOGFILE
    fi

    sleep 2
done

