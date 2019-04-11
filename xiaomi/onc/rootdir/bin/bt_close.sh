#!/vendor/bin/sh
RESULT_PATH="/sdcard"
/vendor/bin/btconfig /dev/smd3 reset
setprop persist.sys.closebt 0
rm $RESULT_PATH/bt_result.txt
exit 0
