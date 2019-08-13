#!/system/bin/sh

echo "[UFS] Parse UFS status +++" > /dev/kmsg
stroage_status=`cat /sys/devices/platform/soc/1d84000.ufshc/ufs_status`
stroage_healthA=`cat /sys/devices/platform/soc/1d84000.ufshc/ufs_health_A`
stroage_healthB=`cat /sys/devices/platform/soc/1d84000.ufshc/ufs_health_B`
storage_preEOL=`cat /sys/devices/platform/soc/1d84000.ufshc/ufs_preEOL | cut -d "x" -f 2`
date=`date "+%Y%m%d"`

setprop asus.storage.primary.health "0x0$storage_preEOL"
setprop asus.storage.primary.healthtypeA "$stroage_healthA"
setprop asus.storage.primary.healthtypeB "$stroage_healthB"
setprop asus.storage.primary.status "0x$storage_preEOL"-"$stroage_healthA"-"$stroage_healthB"-"$stroage_status"-"UFS"-"$date"

setprop asus.storage.primary.type UFS
storage_size=`cat /sys/devices/platform/soc/1d84000.ufshc/ufs_total_size`
setprop asus.storage.primary.size "$storage_size"G

if [ "$storage_preEOL" == "" -o "$stroage_healthA" == "" -o "$stroage_healthB" == "" ]; then
	echo "[UFS] Fail to get UFS status, retry" > /dev/kmsg
	sleep 2

	stroage_status=`cat /sys/devices/platform/soc/1d84000.ufshc/ufs_status`
	stroage_healthA=`cat /sys/devices/platform/soc/1d84000.ufshc/ufs_health_A`
	stroage_healthB=`cat /sys/devices/platform/soc/1d84000.ufshc/ufs_health_B`
	storage_preEOL=`cat /sys/devices/platform/soc/1d84000.ufshc/ufs_preEOL | cut -d "x" -f 2`
	date=`date "+%Y%m%d"`

	setprop asus.storage.primary.health "0x0$storage_preEOL"
	setprop asus.storage.primary.healthtypeA "$stroage_healthA"
	setprop asus.storage.primary.healthtypeB "$stroage_healthB"
	setprop asus.storage.primary.status "0x$storage_preEOL"-"$stroage_healthA"-"$stroage_healthB"-"$stroage_status"-"UFS"-"$date"

	setprop asus.storage.primary.type UFS
	storage_size=`cat /sys/devices/platform/soc/1d84000.ufshc/ufs_total_size`
	setprop asus.storage.primary.size "$storage_size"GB
fi

echo "[UFS] Parse UFS status ---" > /dev/kmsg
