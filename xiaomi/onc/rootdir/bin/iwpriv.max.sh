#!/vendor/bin/sh
echo "iwpriv.max.sh"
ROOT_PATH="/sdcard"
CMD_PATH="/system/etc"
CMD="/vendor/bin/iwpriv"
rm $ROOT_PATH/iwpriv_result.txt
cmd_array=("wlan0 ftm 1" "wlan0 tx 0" "wlan0 ena_chain 2" \
	"wlan0 pwr_cntl_mode 2" "wlan0 set_channel 7" \
	"wlan0 set_txrate MCS_SG_72_2_MBPS" \
	"wlan0 set_txpower 20" "wlan0 tx 1")
#while read line
#do
#		    $CMD $line >> $ROOT_PATH/iwpriv_result.txt 2>&1
#done < $CMD_PATH/iwpriv_para.txt

for line in "${cmd_array[@]}"
do
	$CMD $line >> $ROOT_PATH/iwpriv_result.txt 2>&1
done

setprop persist.sys.iwpriv_max 0
exit 0
