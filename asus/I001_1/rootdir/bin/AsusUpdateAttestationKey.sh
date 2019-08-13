#!/system/bin/sh

echo "[UpdateAttKey] setenforce: permissive" > /proc/asusevtlog
sleep 3
echo 1 > /sys/fs/selinux/log
sleep 3
KmInstallKeybox /vendor/factory/key.xml auto true > /vendor/factory/AsusUpdateAttKey.log 2>&1
echo 0 > /sys/fs/selinux/log
echo "[UpdateAttKey] setenforce: enforcing" > /proc/asusevtlog
