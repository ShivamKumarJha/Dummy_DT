#!/system/vendor/bin/sh

echo "Start clear csc log"
LOG_LOGCAT_FOLDER='/data/logcat_log'
LOG_MODEM_FOLDER='/sdcard/diag_logs'

# Delete logcat log & tcp dump
rm -rf $LOG_LOGCAT_FOLDER/*

# Delete modem log
rm -rf $LOG_MODEM_FOLDER

