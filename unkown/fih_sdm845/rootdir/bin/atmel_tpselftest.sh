#!/vendor/bin/sh

TP_RAWDATA="/data/vendor/misc/touch/TPRawdataFile.txt"
patameter_1=$(getprop vendor.sys.fqctouchpanel)
setprop vendor.sys.fqctpret 1

mxt-app -W -T46 08 -v 0
mxt-app --backup -v 0
mxt-app --reset -v 0
sleep 0.1
mxt-app -t -v 0
TEST_RESULT=$?
sleep 0.2

#Dump raw data
mxt-app -v 0 --reference --debug-dump $TP_RAWDATA
mxt-app -W -T46 00 -v 0
mxt-app --backup -v 0
mxt-app --reset -v 0

if [ "$TEST_RESULT" == "0"  ]; then
	echo "PASS" >> $TP_RAWDATA
	ret=0
elif [ "$TEST_RESULT" == "4"  ]; then
	echo "SelfTest Failed, TIMEOUT" >> $TP_RAWDATA
	ret=1
elif [ "$TEST_RESULT" == "7"  ]; then
	echo "SelfTest Failed, NOT_SUPPORT" >> $TP_RAWDATA
	ret=1
elif [ "$TEST_RESULT" == "12"  ]; then
	echo "SelfTest Failed, AVDD_POWER_TEST_FAIL" >> $TP_RAWDATA
	ret=1
elif [ "$TEST_RESULT" == "13"  ]; then
	echo "SelfTest Failed, PIN_FAULT_TEST_FAIL" >> $TP_RAWDATA
	ret=1
elif [ "$TEST_RESULT" == "15"  ]; then
	echo "SelfTest Failed, SIGNAL_LIMIT_TEST_FAIL" >> $TP_RAWDATA
	ret=1
else
	echo "Unknown message, $TEST_RESULT" >> $TP_RAWDATA
	ret=1
fi

setprop vendor.sys.fqctpret $ret
exit $ret
