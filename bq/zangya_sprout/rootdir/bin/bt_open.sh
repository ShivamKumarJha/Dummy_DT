#!/vendor/bin/sh
#add by zach for test 
RESULT_PATH="/sdcard"
rm $RESULT_PATH/bt_result.txt
#qhcitool cmd 0x03 0x0003
#qhcitool cmd 0x06 0x0003
#qhcitool cmd 0x03 0x0005 0x02 0x00 0x02
#qhcitool cmd 0x03 0x001A 0x03
#qhcitool cmd 0x03 0x0020 0x00
#qhcitool cmd 0x03 0x0022 0x00

echo "start" > $RESULT_PATH/bt_result.txt
btconfig /dev/smd3 rawcmd 0x03 0x0003
echo "1" > $RESULT_PATH/bt_result.txt
btconfig /dev/smd3 rawcmd 0x06, 0x03 
echo "2" > $RESULT_PATH/bt_result.txt
btconfig /dev/smd3 rawcmd 0x03, 0x05, 0x02, 0x00, 0x02 
echo "3" > $RESULT_PATH/bt_result.txt
btconfig /dev/smd3 rawcmd 0x03, 0x1A, 0x03 
echo "4" > $RESULT_PATH/bt_result.txt
btconfig /dev/smd3 rawcmd 0x03, 0x20, 0x00 
echo "5" > $RESULT_PATH/bt_result.txt
btconfig /dev/smd3 rawcmd 0x03, 0x22, 0x00 
echo "end" > $RESULT_PATH/bt_result.txt
setprop persist.sys.openbt 0

