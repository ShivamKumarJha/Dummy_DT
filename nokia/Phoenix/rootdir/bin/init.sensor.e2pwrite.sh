#!/vendor/bin/sh

E2P_ALS_PARTITION="/dev/block/platform/soc/7c4000.sdhci/by-name/mfd"
TEMP="/mnt/vendor/persist/sensors/registry/registry/mfd"
REGISTRY="/mnt/vendor/persist/sensors/registry/registry/stk3x1x_0_platform.als.fac_cal"

chown root:root /mnt/vendor/persist/sensors/registry/registry/

dd if=$E2P_ALS_PARTITION of=$TEMP bs=1 skip=491520 count=159

SENSOR=`cat $TEMP | cut -d'"' -f6`

if [ $SENSOR = "sns_stk3x1x" ]; then
   mv $TEMP $REGISTRY
   chown system:system $REGISTRY
else
   rm $TEMP
fi

chown system:system /mnt/vendor/persist/sensors/registry/registry/
