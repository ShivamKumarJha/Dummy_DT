#!/vendor/bin/sh
feature_enable="disable"
panel="qdcm_calib_data_hx83112_ctc_fhd_video_mode_dsi_panel.xml"
qdcm_path="/data/vendor/display/qdcm_calib_data_hx83112_ctc_fhd_video_mode_dsi_panel.xml"
ori_qdcm_path="/vendor/bin/"
new_qdcm_path="/data/vendor/display/"
#echo $new_qdcm_path$panel > /1.txt
if [ "disable" = $feature_enable ]; then
	setprop persist.vendor.qdcm.configxml 0
	setprop persist.vendor.qdcm.loadxml 0
	setprop persist.vendor.qdcm.uninstall 1
else
	#force pre-load qdcm file to data
	setprop persist.vendor.qdcm.loadxml 1
#	if [ -e $new_qdcm_path$panel ]; then
#		setprop sys.qdcm.configxml 1
#	else
#		if [ -e $ori_qdcm_path$panel ]; then
#			if [ ! -e $new_qdcm_path ]; then
#				mkdir $new_qdcm_path
#				chown system:system $new_qdcm_path
#				chmod 770 $new_qdcm_path
#			fi
#			setprop sys.qdcm.loadxml 1
#		else
#			echo "The preload file is not exist"
#		fi
#	fi
fi
