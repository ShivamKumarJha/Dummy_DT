#! /vendor/bin/sh
prog_folder=/data/vendor/camera
fcat_result_root=/sdcard/DCIM
value_prop="sys.fcat.value"
enable_prop="sys.fcat.enable"
value=99999
num=$1
num=${num:-1}

#cmd list
fcat_cmd[1]=fcat1
fcat_cmd[2]=fcat2
fcat_cmd[3]=hot_pixel_1
fcat_cmd[4]=hot_pixel_2
fcat_cmd[5]=tilt
fcat_cmd[6]=gm
fcat_cmd[7]=pm

setprop $value_prop $value

if [ "$num" -lt "1" ] || [ "$num" -gt "7" ]; then
	echo "Wrong select test number:$num"
	value=-999
else
	script_file=${fcat_cmd[$num]}.sh
	if [ -e $prog_folder/$script_file ]; then
		rm -rf $fcat_result_root/${fcat_cmd[$num]}
		cd $prog_folder;
		./$script_file
		value=$?
	else
		echo "No such file $script_file"
		value=$((${num}-999))
	fi
fi

setprop $value_prop $value
setprop $enable_prop 0

return $value
