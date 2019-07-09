#!/system/bin/sh

cat /proc/ht_report > /data/local/tmp/ht_`date +%Y.%m.%d-%H.%M.%S`.xls
