#!/system/bin/sh

# saveramdump
SAVE_LOG_ROOT=/data/media/ap_ramdump
BUSYBOX=busybox
skipramdump_flag=`getprop sys.asus.skipramdump`
if busybox test "$skipramdump_flag" -eq 1;then
	echo "format cache partition(ext4) and remount"
	mke2fs -T ext4 /dev/block/platform/msm_sdcc.1/by-name/cache
	mount -t ext4 -o nosuid,nodev,barrier=1,data=ordered,noauto_da_alloc /dev/block/platform/msm_sdcc.1/by-name/cache /cache
	chmod 770 /cache
	chown system.cache /cache
	mkdir /cache/recovery
	chmod 770 /cache/recovery
	chown system.cache /cache/recovery
############################################################################################
	# sync data to disk 
	sync
else
############################################################################################	
	# create savelog folder (UTC)
	SAVE_LOG_PATH="$SAVE_LOG_ROOT/`date +%Y_%m_%d_%H_%M_%S`"
	$BUSYBOX mkdir -p $SAVE_LOG_PATH
	setprop asus.savelogmtp.folder $SAVE_LOG_PATH
	echo "$BUSYBOX mkdir -p $SAVE_LOG_PATH"
############################################################################################
	# save software version
	AP_VER=`getprop ro.build.display.id`
	CP_VER=`getprop gsm.version.baseband`
	BUILD_DATE=`getprop ro.build.date`
	echo "AP_VER: $AP_VER" > $SAVE_LOG_PATH/version.txt
	echo "CP_VER: $CP_VER" >> $SAVE_LOG_PATH/version.txt
	echo "BUILD_DATE: $BUILD_DATE" >> $SAVE_LOG_PATH/version.txt
############################################################################################
	# copy asusdbg(reset debug message) to /data/media
	$BUSYBOX mkdir -p $SAVE_LOG_PATH/resetdbg
	dd if=/dev/block/platform/msm_sdcc.1/by-name/cache of=$SAVE_LOG_PATH/resetdbg/kernelmessage.txt count=512	
	echo "copy asusdbg(reset debug message) to $SAVE_LOG_PATH/resetdbg"
############################################################################################
	dd if=/dev/block/platform/msm_sdcc.1/by-name/cache of=$SAVE_LOG_PATH/IMEM_C.BIN count=8 skip=512
	dd if=/dev/block/platform/msm_sdcc.1/by-name/cache of=$SAVE_LOG_PATH/EBICS0.BIN count=2097152 skip=2048	
	echo "copy RAMDUMP.bin to $SAVE_LOG_PATH"
############################################################################################
	echo "format cache partition(ext4) and remount"
	mke2fs -T ext4 /dev/block/platform/msm_sdcc.1/by-name/cache
	mount -t ext4 -o nosuid,nodev,barrier=1,data=ordered,noauto_da_alloc /dev/block/platform/msm_sdcc.1/by-name/cache /cache
	chmod 770 /cache
	chown system.cache /cache
	mkdir /cache/recovery
	chmod 770 /cache/recovery
	chown system.cache /cache/recovery
############################################################################################
	# sync data to disk 
	sync
	chmod -R 777 "$SAVE_LOG_PATH"
am broadcast -a android.intent.action.MEDIA_MOUNTED --ez read-only false -d file:///mnt/sdcard/sync -p com.android.providers.media
fi
