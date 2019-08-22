#! /vendor/bin/sh

VERSION_FILE="/mnt/vendor/persist/sensors/version.txt"
if [ -f $VERSION_FILE ]; then
  VERSIONTEXT=`head -n 1 $VERSION_FILE`
else
  VERSIONTEXT="none"
fi

SWLABEL=`getprop ro.vendor.build.date.utc`
DST_CONFIG_JSON_FILE_DIR="/mnt/vendor/persist/sensors/registry/config"
DST_SOMC_JSON_FILE_DIR="/mnt/vendor/persist/sensors/registry/somc"
DST_JSON_FILE_DIR="/mnt/vendor/persist/sensors"
SRC_JSON_FILE_DIR="/vendor/etc/sensors/registry"

if [ $SWLABEL = $VERSIONTEXT ] && [ -n $VERSIONTEXT ]; then
  exit
fi

if [ -e $DST_CONFIG_JSON_FILE_DIR ]; then
  rm -rf $DST_CONFIG_JSON_FILE_DIR
fi

if [ -e $DST_SOMC_JSON_FILE_DIR ]; then
  rm -rf $DST_SOMC_JSON_FILE_DIR
fi

if [ -e $SRC_JSON_FILE_DIR ]; then
  cp -a $SRC_JSON_FILE_DIR $DST_JSON_FILE_DIR
fi
