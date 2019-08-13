#!/system/bin/sh

LOG_TAG="antennaSwitchSvc"

# HW Table
# 0 EVB
# 1 SR
# 2 ER1
# 3 ER2
# 4 PR1
# 5 PR2
# 7 MR
PROJECT_ID="ro.boot.id.stage"
DBG_PROPERTY="debug.antennaSwitchSvc"
APM_PROPERTY="persist.vendor.radio.airplane_mode_on"

mPrjID=`getprop $PROJECT_ID`
mState=`getprop $APM_PROPERTY`
mDebug=`getprop $DBG_PROPERTY`

if [ ! -z "$mState" ] && [[ "$mPrjID" -gt "3" || "$mDebug" == "enable" ]] ; then
    if [ "$mState" == "1" ]; then
        log -t $LOG_TAG "diable switch"
        echo '0' > /sys/devices/platform/soc/4080000.qcom,mss/antennaSwitch
    else
        log -t $LOG_TAG "enable switch"
        echo '1' > /sys/devices/platform/soc/4080000.qcom,mss/antennaSwitch
    fi
fi
