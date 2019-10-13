#! /vendor/bin/sh

#ifdef VENDOR_EDIT
#Xiao.Liang@PSW.CN.WiFi.Basic.Log.1072015, 2018/10/22, Add for collecting wifi driver log

DATA_LOG_PATH=/data/vendor/wifi/logs
option="$1"


function defaultaction(){
     echo Something wrong!!!
}

function prepacketlog(){
    panicstate=`getprop persist.sys.assert.panic`
    packetlogstate=`getprop persist.sys.wifipacketlog.state`
    packetlogbuffsize=`getprop persist.sys.wifipktlog.buffsize`
    timeout=0

    if [ "${panicstate}" = "true" ] && [ "${packetlogstate}" = "true" ];then
        echo Disable it before we set the size...
        setprop ctl.start setiwprivpkt0
        while [ $? -ne "0" ];do
            echo wait util the file system is built.
            sleep 2
            if [ $timeout -gt 30 ];then
                echo less than the numbers  we want...
                echo can not finish prepacketlog... > ${DATA_LOG_PATH}/pktlog_error.txt
                setprop ctl.start setiwprivpkt0 >> ${DATA_LOG_PATH}/pktlog_error.txt
                exit
            fi
            let timeout+=1;
            setprop ctl.start setiwprivpkt0
        done
        if [ "${packetlogbuffsize}" = "1" ];then
            echo Set the pktlog buffer size to 100MB...
            pktlogconf -s 100000000 -a cld
        else
            echo Set the pktlog buffer size to 20MB...
            pktlogconf -s 20000000 -a cld
        fi

        echo Enable the pktlog...
        setprop ctl.start setiwprivpkt1
    fi
}

function wifipktlogtransf(){
    LOGTIME=`getprop persist.sys.com.oppo.debug.time`
    ROOT_SDCARD_LOG_PATH=/data/vendor/wifi/logs/${LOGTIME}/wlan_logs
    echo $ROOT_SDCARD_LOG_PATH
    packetlogstate=`getprop persist.sys.wifipacketlog.state`

    setprop ctl.start setiwprivpkt0
    while [ $? -ne "0" ];do
        echo wait util the file system is built.
        sleep 2
        if [ $timeout -gt 30 ];then
            echo less than the numbers  we want...
            echo can not finish prepacketlog... > ${DATA_LOG_PATH}/pktlog_error.txt
            setprop ctl.start setiwprivpkt0 >> ${DATA_LOG_PATH}/pktlog_error.txt
            exit
        fi
        let timeout+=1;
        setprop ctl.start setiwprivpkt0
    done
    if [ "${packetlogstate}" = "true" ];then
        echo transfer start...

        cat /proc/ath_pktlog/cld > ${ROOT_SDCARD_LOG_PATH}/pktlog.dat
        setprop ctl.start setiwprivpkt4
        echo transfer end...
    fi
    pktlogconf -s 10000000 -a cld
    setprop ctl.start setiwprivpkt1
}

function switchWiFiIniForRoam() {
    # Notice that /storage/persist is link of /mnt/vendor/persist
    dstFile="/storage/persist/WCNSS_qcom_cfg.ini"

    wifiRoamEnable=`getprop oppo.wifi.roaming.enabled`
    # if property is empty, indicate this is the first time of call, set the property
    if [ -z "$wifiRoamEnable" ]; then
        if [ -f "$dstFile" ]; then
            wifiRoamEnable=$(cat "$dstFile" | grep "gEnableImps=" | awk -F "=" '{print $2}')
            if [ "$wifiRoamEnable" -ne "1" ]; then
                wifiRoamEnable=0
            fi
            echo "oppo.wifi.roaming.enabled is empty, set value to $wifiRoamEnable"
            setprop oppo.wifi.roaming.enabled "$wifiRoamEnable"
            exit
        fi
    fi

    if [ "0" == "$wifiRoamEnable" ]; then
        srcFile="/system/vendor/etc/wifi/WCNSS_qcom_cfg_cmcc.ini"
    else
        srcFile="/system/vendor/etc/wifi/WCNSS_qcom_cfg.ini"
    fi

    # check whether file have been modified, should this can happen?
    srcMd5=`md5sum $srcFile`
    dstMd5=`md5sum $dstFile`
    if [ "$srcMd5" == "$dstMd5" ]; then
        echo "source file and dest file is same, ignore it"
        exit
    fi

    cp -f "$srcFile" "$dstFile"
}

function WifibdfVersion() {
    bdfFile="/mnt/vendor/persist/WCNSS_qcom_wlan_nv.bin"
    bdfMd5=`md5sum $bdfFile`
    setprop oppo.wifi.bdfver "$bdfMd5"
}

case "$option" in
    "prepacketlog")
        prepacketlog
        ;;
    "wifipktlogtransf")
        wifipktlogtransf
        ;;
        #end
    "switchWiFiIniForRoam")
        switchWiFiIniForRoam
        ;;
    "WifibdfVersion")
        WifibdfVersion
        ;;
        #end
       *)
    defaultaction
      ;;
esac
#endif /*VENDOR_EDIT*/
