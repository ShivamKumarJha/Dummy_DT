#!/system/bin/sh
BUGREPORT_PATH=/data/user_de/0/com.android.shell/files/bugreports
GENERAL_LOG=/data/media/0/ASUS/LogUploader/general/sdcard


dumpstate -q -d -z -o $BUGREPORT_PATH/bugreport
for filename in $BUGREPORT_PATH/*; do
	name=${filename##*/}
        cp $filename  $GENERAL_LOG/$name
        rm $filename
done

chmod -R 777 $GENERAL_LOG

setprop persist.asus.uts com.asus.savelogs.completed
setprop persist.asus.savelogs.complete 0
setprop persist.asus.savelogs.complete 1

