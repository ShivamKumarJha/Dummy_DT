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

#Add for: close fw log when 6125 aging test.
function prewifidriverlog(){
    platform=`getprop ro.board.platform`
    special_oppo_cfg=`getprop SPECIAL_OPPO_CONFIG`

    if [ "${platform}" = "trinket" -a "${special_oppo_cfg}" = "1" ];then
        setprop oppo.wifi.fwlog.state false
    else
        setprop oppo.wifi.fwlog.state true
    fi
}
#end

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
    bdfFile="/mnt/vendor/persist/bdwlan.bin"
    bdfMd5=`md5sum $bdfFile`
    setprop oppo.wifi.bdfver "$bdfMd5"
}

#Jiaobo@PSW.CN.WiFi.Basic.Switch.2121524, 2019/06/24
#Add for: check persist partition, use default WCNSS_qcom_cfg.ini when the persist partition is mount failed
function wlanpersistmountcheck() {
    PERSIST_WIFI_CONFIG_BDF_PATH="/mnt/vendor/persist"
    PERSIST_WIFI_CONFIG_FILE="/mnt/vendor/persist/WCNSS_qcom_cfg.ini"
    PERSIST_WIFI_BDF_FILE="/mnt/vendor/persist/bdwlan.bin"

    if [ ! -d ${PERSIST_WIFI_CONFIG_BDF_PATH} ];then
        echo "persist partition may mount failed."
        setprop vendor.oppo.wifi.check.persist mount_invaild_folder
    else
        if [ ! -f ${PERSIST_WIFI_CONFIG_FILE} -o ! -f ${PERSIST_WIFI_BDF_FILE} ];then
            if [ ! -f ${PERSIST_WIFI_CONFIG_FILE} -a ! -f ${PERSIST_WIFI_BDF_FILE} ];then
                setprop vendor.oppo.wifi.check.persist mount_invaild_all
            else
                if [ ! -f ${PERSIST_WIFI_BDF_FILE} ];then
                    setprop vendor.oppo.wifi.check.persist mount_invaild_bdf
                fi
                if [ ! -f ${PERSIST_WIFI_CONFIG_FILE} ];then
                    setprop vendor.oppo.wifi.check.persist mount_invaild_ini
                fi
            fi
        else
            setprop vendor.oppo.wifi.check.persist mount_vaild
        fi
    fi
}
#end

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
    #Add for: close fw log when 6125 aging test.
    "prewifidriverlog")
        prewifidriverlog
        ;;
    #end
    #Jiaobo@PSW.CN.WiFi.Basic.Switch.2121524, 2019/06/24
    #Add for: check persist partition, use default WCNSS_qcom_cfg.ini when the persist partition is mount failed
    "wlanpersistmountcheck")
        wlanpersistmountcheck
        ;;
    #end
       *)
    defaultaction
      ;;
esac
#endif /*VENDOR_EDIT*/
