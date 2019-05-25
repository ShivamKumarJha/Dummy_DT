#!/system/bin/sh

# persist.sys.modem.restart
# 1:UI 2:ramdump 4:modem 8:wifi 16:others
#
SUBSYS_MODEM="modem"
SUBSYS_WIFI="adsp"
MAX_NUM_SUBSYS=10
SUBSYS_PATH="/sys/bus/msm_subsys/devices/subsys"
SUBSYS_OTHERS_NUM=0
SUBSYS_OTHERS=""

function LOG () {
  log -p d -t ssr_cfg "$1"
}

index=0
LOG "index = ${index} ; MAX_NUM_SUBSYS = ${MAX_NUM_SUBSYS}"
while [ "${index}" -lt "${MAX_NUM_SUBSYS}" ] ; do
  LOG "Path : ${SUBSYS_PATH}${index}"
  if [ -d "${SUBSYS_PATH}${index}" ] ; then
    LOG "Path_Name : ${SUBSYS_PATH}${index}/name"
    name=`cat ${SUBSYS_PATH}${index}/name`
    LOG "Name : $name"
    if [ "$name" != "" -a "$name" != "${SUBSYS_MODEM}" -a "$name" != "${SUBSYS_WIFI}" ] ; then
      SUBSYS_OTHERS_NUM=$(( ${SUBSYS_OTHERS_NUM}+1 ))
      if [ ${SUBSYS_OTHERS_NUM} == 1 ] ; then
        SUBSYS_OTHERS=${name}
      else
        SUBSYS_OTHERS=${SUBSYS_OTHERS}" "${name}
      fi
    fi
  fi
  index=$(( ${index}+1 ))
done

#echo "SUBSYS_OTHERS_NUM = ${SUBSYS_OTHERS_NUM} ; SUBSYS_OTHERS = ${SUBSYS_OTHERS}"
LOG "SUBSYS_OTHERS_NUM = ${SUBSYS_OTHERS_NUM} ; SUBSYS_OTHERS = ${SUBSYS_OTHERS}"

prop=`getprop persist.sys.modem.restart`

restartlevel=$(($prop & 28))
dump=$((($prop & 2) / 2))

case $restartlevel in
  "4")
  setprop persist.vendor.ssr.restart_level "${SUBSYS_MODEM}"
  ;;
  "8")
  setprop persist.vendor.ssr.restart_level "${SUBSYS_WIFI}"
  ;;
  "16")
  setprop persist.vendor.ssr.restart_level "${SUBSYS_OTHERS}"
  ;;
  "12")
  setprop persist.vendor.ssr.restart_level "${SUBSYS_MODEM} ${SUBSYS_WIFI}"
  ;;
  "20")
  setprop persist.vendor.ssr.restart_level "${SUBSYS_MODEM} ${SUBSYS_OTHERS}"
  ;;
  "24")
  setprop persist.vendor.ssr.restart_level "${SUBSYS_WIFI} ${SUBSYS_OTHERS}"
  ;;
  "28")
  setprop persist.vendor.ssr.restart_level "ALL_ENABLE"
  ;;
  *)
  setprop persist.vendor.ssr.restart_level "ALL_DISABLE"
  ;;
esac

if [ ${dump} -ne 0 ]; then
	setprop persist.vendor.sys.ssr.enable_ramdumps 1
else
	setprop persist.vendor.sys.ssr.enable_ramdumps 0
fi
