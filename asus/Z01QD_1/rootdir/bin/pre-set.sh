echo "======================================="
echo "1. preparing adb"
adb wait-for-device root
adb wait-for-device remount
adb wait-for-device shell setenforce 0
adb wait-for-device shell getenforce
echo "======================================="

echo "======================================="
echo "2. delete built-in demo application if any"
adb wait-for-device push SNTMfgUtil vendor/bin/
adb wait-for-device push d1testcap vendor/bin/
adb wait-for-device shell chmod 777 vendor/bin/SNTMfgUtil
adb wait-for-device shell chmod 777 vendor/bin/d1testcap
echo "======================================="
