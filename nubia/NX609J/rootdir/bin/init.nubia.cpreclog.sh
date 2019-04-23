#!/vendor/bin/sh
if [ -d "/cache/recovery" ]; then
    if [ ! -d "/date/media/0/logs/recovery " ]; then
        mkdir -p /data/media/0/logs/recovery
    fi
    echo "$0: Copy recovery log to internal sdcard ..."
    cp -r /cache/recovery/* /data/media/0/logs/recovery/
    chmod -R 775 /data/media/0/logs/
    chown -R media_rw.media_rw /data/media/0/logs
else
    echo "$0: /cache/recovery is not exist"
fi
if [ -d "/cache/FTM_AP/mmi_log" ]; then
    if [ ! -d "/date/media/0/logs/mmi_log " ]; then
        mkdir -p /data/media/0/logs/mmi_log
    fi
    echo "$0: Copy ffbm  log to internal sdcard ..."
    cp -r /cache/FTM_AP/mmi_log /data/media/0/logs/mmi_log/
    cp -r /cache/FTM_AP/mmi_log* /data/media/0/logs/mmi_log/
    chmod -R 775 /data/media/0/logs/
    chown -R media_rw.media_rw /data/media/0/logs
else
    echo "$0: /cache/FTM_AP/mmi_log is not exist"
fi

