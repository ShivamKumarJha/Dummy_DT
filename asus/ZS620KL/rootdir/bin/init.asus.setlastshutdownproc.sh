#!/system/bin/sh

chmod 0777 /proc/asusdebug
echo load > /proc/asusdebug
echo get_lastshutdown_log > /proc/asusdebug
