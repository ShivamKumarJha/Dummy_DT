#!/vendor/bin/sh

export PATH=/vendor/bin

###### Apply K data ######
GRIP_CAL_FILE="/vendor/factory/snt_reg_init"
if [ -f $GRIP_CAL_FILE ]; then
    #cat /vendor/factory/snt_reg_init > /sys/snt8100fsr/boot_init_reg
    cat /vendor/factory/snt_reg_init > /proc/driver/Grip_ReadK
else
    echo 1 > /proc/driver/Grip_Apply_GoldenK_F
fi

##### Check Panel ID #####
if [ -f "/vendor/factory/sensors/grip_panel_id" ]; then
    setprop vendor.grip.panel_file "exist"
    Panel_ID_now="`cat /proc/lcd_unique_id`"
    Panel_ID_orig="`cat /vendor/factory/sensors/grip_panel_id`"
    echo "orig:$Panel_ID_orig now:$Panel_ID_now"
    if [ "$Panel_ID_orig" == "$Panel_ID_now" ]; then
        setprop vendor.grip.panel.changed 0
        echo 0 > /proc/driver/Grip_FPC_Check
        echo "panel id not change"
    else
        setprop vendor.grip.panel.changed 1
        echo 1 > /proc/driver/Grip_FPC_Check
        echo "get changed panel id"
    fi
else
    # if no panel_id, skip panel_id check
    setprop vendor.grip.panel_file "none"
fi
##### Check FW Result #####
FW_Check="`cat /proc/driver/grip_fw_result`"
setprop vendor.grip.fw.result $FW_Check
setprop grip.fw.result $FW_Check

#### Check FW Version #### 
echo "setprop fw_result"
FW_VER="`cat /proc/driver/grip_fw_ver| cut -d ":" -f 2`"
FW_VER=`echo $FW_VER | cut -d ' ' -f 1`
setprop vendor.grip.fw.version $FW_VER
setprop grip.fw.version $FW_VER

#### Check FPC Status ####
Bar0="`cat /proc/driver/Grip_FPC_Check`"
setprop vendor.grip.bar.result $Bar0
if [ "$Bar0" == "0xffff" ]; then
    setprop vendor.grip.bar.status 1
else
    setprop vendor.grip.bar.status 0
fi

#### Check Golden K apply status ####
Golden_K_Flag="`cat /proc/driver/Grip_Apply_GoldenK_F`"
B0_F="`cat /proc/driver/Grip_SQ_B0_factor`"
B1_F="`cat /proc/driver/Grip_SQ_B1_factor`"
#B2_F="`cat /proc/driver/Grip_SQ_B2_factor`"
setprop vendor.grip.Apply_GoldenK_F $Golden_K_Flag
setprop vendor.grip.b0.30N.val $B0_F
setprop vendor.grip.b1.30N.val $B1_F
#setprop vendor.grip.b2.30N.val $B2_F

#Bar1="`/data/data/GripSensor_SelfTest 0`"
#Bar1="`/data/data/GripSensor_SelfTest 1`"
#Bar2="`/data/data/GripSensor_SelfTest 2`"
#setprop debug.grip.bar0.status $Bar0
#setprop debug.grip.bar1.status $Bar1
#setprop debug.grip.bar2.status $Bar2
