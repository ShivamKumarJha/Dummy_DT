#!/vendor/bin/sh

GSENSOR_CAL_X="/vendor/factory/sensors/gsensor_cal_x"
GSENSOR_CAL_Y="/vendor/factory/sensors/gsensor_cal_y"
GSENSOR_CAL_Z="/vendor/factory/sensors/gsensor_cal_z"

ALS_50MS="/vendor/factory/sensors/als_cal_50ms"
ALS_100MS="/vendor/factory/sensors/als_cal_100ms"
ALS_SPEC="/data/data/lightsensor_spec"

PS_INF="/vendor/factory/sensors/ps_cal_inf"
PS_1CM="/vendor/factory/sensors/ps_cal_1cm"
PS_2CM="/vendor/factory/sensors/ps_cal_2cm"
PS_4CM="/vendor/factory/sensors/ps_cal_4cm"
PS_SPEC="/data/data/proximity_spec"

FRGB_RED_RATIO="/vendor/factory/sensors/frgb_red_ratio"
FRGB_GREEN_RATIO="/vendor/factory/sensors/frgb_green_ratio"
FRGB_BLUE_RATIO="/vendor/factory/sensors/frgb_blue_ratio"
FRGB_LIGHT1_RED="/vendor/factory/sensors/frgb_light1_red"
FRGB_LIGHT1_GREEN="/vendor/factory/sensors/frgb_light1_green"
FRGB_LIGHT1_BLUE="/vendor/factory/sensors/frgb_light1_blue"
FRGB_LIGHT1_IR="/vendor/factory/sensors/frgb_light1_ir"
FRGB_LIGHT2_RED="/vendor/factory/sensors/frgb_light2_red"
FRGB_LIGHT2_GREEN="/vendor/factory/sensors/frgb_light2_green"
FRGB_LIGHT2_BLUE="/vendor/factory/sensors/frgb_light2_blue"
FRGB_LIGHT2_IR="/vendor/factory/sensors/frgb_light2_ir"
FRGB_LIGHT3_RED="/vendor/factory/sensors/frgb_light3_red"
FRGB_LIGHT3_GREEN="/vendor/factory/sensors/frgb_light3_green"
FRGB_LIGHT3_BLUE="/vendor/factory/sensors/frgb_light3_blue"
FRGB_LIGHT3_IR="/vendor/factory/sensors/frgb_light3_ir"
FRGB_SPEC="/data/data/frgbsensor_spec"

sensor_chmod()
{
        if [ -f $1 ];
        then
                echo "File $FILE exists"
                chmod 660 $1
                chown system:shell $1
        else
                echo "File $FILE does not exists"
                echo 0 > $1
                chmod 660 $1
                chown system:shell $1
        fi
}

sensor_chmod $GSENSOR_CAL_X
sensor_chmod $GSENSOR_CAL_Y
sensor_chmod $GSENSOR_CAL_Z

sensor_chmod $ALS_50MS
sensor_chmod $ALS_100MS
sensor_chmod $ALS_SPEC

sensor_chmod $PS_INF
sensor_chmod $PS_1CM
sensor_chmod $PS_2CM
sensor_chmod $PS_4CM
sensor_chmod $PS_SPEC

sensor_chmod $FRGB_RED_RATIO
sensor_chmod $FRGB_GREEN_RATIO
sensor_chmod $FRGB_BLUE_RATIO
sensor_chmod $FRGB_LIGHT1_RED
sensor_chmod $FRGB_LIGHT1_GREEN
sensor_chmod $FRGB_LIGHT1_BLUE
sensor_chmod $FRGB_LIGHT1_IR
sensor_chmod $FRGB_LIGHT2_RED
sensor_chmod $FRGB_LIGHT2_GREEN
sensor_chmod $FRGB_LIGHT2_BLUE
sensor_chmod $FRGB_LIGHT2_IR
sensor_chmod $FRGB_LIGHT3_RED
sensor_chmod $FRGB_LIGHT3_GREEN
sensor_chmod $FRGB_LIGHT3_BLUE
sensor_chmod $FRGB_LIGHT3_IR
sensor_chmod $FRGB_SPEC

eixt 0
