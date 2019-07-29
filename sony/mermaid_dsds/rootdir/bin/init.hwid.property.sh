#! /vendor/bin/sh

cei_project_id=`cat /proc/cei_project_id`
cei_phase_id=`cat /proc/cei_phase_id`
cei_sku_id=`cat /proc/cei_sku_id`
cei_mainboard_id=`cat /proc/cei_mainboard_id`

if [ -n $cei_project_id ]; then
	setprop ro.vendor.cei_project_id $cei_project_id
else
	setprop ro.vendor.cei_project_id PROJ_ID_INVALID
fi

if [ -n $cei_phase_id ]; then
	setprop ro.vendor.cei_phase_id $cei_phase_id
else
	setprop ro.vendor.cei_project_id HW_ID_INVALID
fi

if [ -n $cei_sku_id ]; then
	setprop ro.vendor.cei_sku_id $cei_sku_id
else
	setprop ro.vendor.cei_sku_id_id Unknown
fi

if [ -n $cei_mainboard_id ]; then
	setprop ro.vendor.cei_mainboard_id $cei_mainboard_id
else
	setprop ro.vendor.cei_mainboard_id Unknown
fi

