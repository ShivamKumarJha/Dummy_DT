#wait phone power on
sleep 60 

BIN=/vendor/bin/inotifywait
PARMS="-rm -e moved_to -e moved_from -e delete -e create"
DIRS="/data/media/0/DCIM /data/media/0/Pictures"
BASEPATH=/sdcard/smartisan/.log
LOGPATH=$BASEPATH/gallery
LOGFILE=$LOGPATH/inotifylog
IDXFILE=$LOGPATH/ino_idx

times=0
while [ ture ];do
	if [ -d "$LOGPATH" ]; then 
		break;
	fi
	if [ -d "$BASEPATH" ]; then 
		mkdir -p $LOGPATH
		break;
	fi
	sleep 60
	times=$((times+1))
	if [ $((times)) -gt 10 ]; then
		exit 0
	fi
done;
#set log file idx 
if [ ! -f "$IDXFILE" ]; then
	echo 1 > $IDXFILE
fi 
while [ ture ];do
	#echo $BIN $PARMS $DIRS
	touch $LOGFILE
	$BIN $PARMS --timefmt '%Y%m%d_%H:%M:%S' --format '%T %e %w%f' $DIRS -o $LOGFILE &
	pid=$!
	sleep 60
	while [ true ];do
		# check pid is runing
		kill -0 $pid
		if [ $? -ne 0 ];then
			echo "$pid is not running"
			break;
		fi

		filesize=`stat -c "%s" $LOGFILE`
		#echo filesize=$filesize
		if [ $((filesize)) -gt 10485760 ];then
			#kill task and backup log file
			echo kill pid=$pid
			kill -9 $pid
			sleep 10
			idx=`cat $IDXFILE`
			#echo idx=$idx
			mv $LOGFILE $LOGFILE$idx
			gzip -f $LOGFILE$idx
			idx=$((idx+1))
			if [ $((idx)) -gt 5 ];then
				idx=0
			fi
			echo $idx > $IDXFILE
			break;
		else
			# log will be deleted after upload, so restart service
			if [ ! -f "$LOGFILE" ]; then
				kill -9 $pid
				sleep 5
				exit 0
			fi

			if [ ! -f "$IDXFILE" ]; then
				kill -9 $pid
				sleep 5
				exit 0
			fi

			sleep 300
			#echo "sleep 300s"
		fi
	done;
done;

