#! /vendor/bin/sh
#defined return values
pass=0
para_fail=$(($pass + 1))
init_fail=$(($para_fail + 1))
chkfile_fail=$(($init_fail + 1))
erase_fail=$(($chkfile_fail + 1))
write_fail=$(($erase_fail + 1))
ddr_fail=$(($write_fail + 1))

#asic power related
asic_pwr_ctrl=/sys/asic/link/asic_power
asic_pwr_on=1
asic_pwr_off=0
asic_lcc_fw_version="lcc -m 0 -s 0 -r -p 00 00 04 02"

#spi control related
spi_path_ctrl=/sys/devices/platform/soc/soc:spi_switch/control/mode
asic_spi_ctrl_str="asic"
qcom_spi_ctrl_str="qcom"

#mtd device related
mtd_module_name=m25p80.ko
mtd_module_file=/vendor/lib/modules/$mtd_module_name
mtd_dev=/dev/mtd/mtd0
erase_cmd="mtd_debug erase"
write_cmd="mtd_debug write"
read_cmd="mtd_debug read"

#asic fw version related
data_folder=/data/vendor/asic
curr_fw="fw_curr.bin"
tmp_fw="fw_tmp.bin"
fw_read_chunk=65536

#hwid path
hw_ver_path=/proc/baseband

#fw store folder
fw_folder=/vendor/etc
l16_fw=asic_fw_l16.bin
fl5_fw=asic_fw_fl5.bin

#index into the table
index_spi_hdr=0
index_fw_actid=$(($index_spi_hdr + 1))
index_board_ver=$(($index_fw_actid + 1))
index_fw=$(($index_board_ver + 1))
index_cal=$(($index_fw + 1))
index_cal_hdr=$(($index_cal + 1))

#default index (from spi-hdr to asic-fw)
start_index=$index_spi_hdr
end_index=$index_fw
check_fwver_flag=0
update_fw_flag=1
ddr_test_wait_sec=9

#file array
files[$index_spi_hdr]=spi_header.bin
files[$index_fw_actid]=fw_active_id.bin
files[$index_board_ver]=
files[$index_fw]=asic_fw.bin
files[$index_cal]=asic_cal.bin
files[$index_cal_hdr]=asic_cal_hdr.bin

#partition offset array
offset[$index_spi_hdr]="0x00000"
offset[$index_fw_actid]="0x60000"
offset[$index_board_ver]="0x150000"
offset[$index_fw]="0x70000"
offset[$index_cal]="0x110000"
offset[$index_cal_hdr]="0x140000"

#partition length array
length[$index_spi_hdr]="0x10000"
length[$index_fw_actid]="0x10000"
length[$index_board_ver]="0x10000"
length[$index_fw]="0xA0000"
length[$index_cal]="0x10000"
length[$index_cal_hdr]="0x10000"

# ========================== Functions ===============================
print_usage()
{
	echo "\nUsage: $0 [-onlyfw | -onlycal | -withcal]\n"
	echo "  (default update ${files[$index_spi_hdr]}, ${files[$index_fw_actid]} and ${files[$index_fw]})"
	echo "  -onlyfw:    only update ${files[$index_fw]}"
	echo "  -onlycal:   only update ${files[$index_cal]} and ${files[$index_cal_hdr]}"
	echo "  -withcal:   additional update ${files[$index_cal]} and ${files[$index_cal_hdr]} with default"
}

exit_update()
{
	result=$1
	rmmod $mtd_module_name
	echo $asic_spi_ctrl_str > $spi_path_ctrl
	if [ $result -ne $pass ]; then
		exit $result
	fi
}

validate_fw_flash()
{
	ver_string=$($asic_lcc_fw_version)
	result=$?
	echo lcc-ret:$ver_string
	if [ $result -ne $pass ]; then
		echo "FAIL, DDR check result:$result!!"
		return $ddr_fail
	fi

	echo "DDR Check Pass!"
	return $pass
}

set_fw_by_hw_ver()
{
	hwver=$(cat $hw_ver_path)
	major=${hwver%%.*}
	if [ $major -ge 3 ]; then
		# DVT or later hw would use fl5 firmware
		files[$index_fw]=$fl5_fw
	else
		files[$index_fw]=$l16_fw
	fi
	echo "HWID:$hwver, use ${files[$index_fw]}"
}

update_init()
{
	echo $asic_pwr_off > $asic_pwr_ctrl
	echo $qcom_spi_ctrl_str > $spi_path_ctrl
	insmod $mtd_module_file

	for i in $(seq 0 2)
	do
		if [ -e $mtd_dev ]; then
			return $pass
		else
			sleep 0.5
		fi
	done

	cur_spi_path=$(cat $spi_path_ctrl)
	echo "FAIL, No such file: \"$mtd_dev\", insert module errorno:$result (spi:$cur_spi_path)"
	return $init_fail
}

check_upgrade_required()
{
	#get new-fw md5sum
	fw=$fw_folder/${files[$index_fw]}
	if [ -f $fw ]; then
		new_md5=($(md5sum ${fw}))
		size=$(stat -c%s $fw)
	else
		echo "FAIL, No such file: $fw"
		return $chkfile_fail
	fi

	#read back fw from flash to get md5sum
	flash_fw=$data_folder/$curr_fw
	chunk=$data_folder/$tmp_fw
	rm -f $flash_fw
	rm -f $chunk
	off=${offset[$index_fw]}
	while [ $size -ne 0 ]
	do
		if [ $size -gt $fw_read_chunk ]; then
			$read_cmd $mtd_dev $off $fw_read_chunk $chunk
			size=$(($size - fw_read_chunk))
			off=$(($off + fw_read_chunk))
		else
			$read_cmd $mtd_dev $off $size $chunk
			size=0
		fi
		cat $chunk >> $flash_fw
		rm -f $chunk
	done
	curr_fw_md5=($(md5sum ${flash_fw}))
	rm -f $flash_fw

	if [ "$new_md5" = "$curr_fw_md5" ]; then
		return 0
	fi
	return 1
}

update_one_part()
{
	par_off=$1
	par_len=$2
	file=$3
	file_size=0
	full_path=$fw_folder/$file

	#check file and get file size
	if [ -n "$file" ]; then
		if [ -f $full_path ]; then
			file_size=$(stat -c%s $full_path)
		else
			echo "FAIL, No such file: $full_path"
			return $chkfile_fail
		fi
	fi

	#erase the particular partition
	$erase_cmd $mtd_dev $par_off $par_len
	if [ $? -ne 0 ]; then
		echo "FAIL, erase $file partition"
		return $erase_fail
	fi

	if [ $file_size -gt 0 ]; then
		# write and verity the particular partion
		$write_cmd $mtd_dev $par_off $file_size $full_path
		if [ $? -ne 0 ]; then
			echo "FAIL, write/verify $file partition"
			return $write_fail
		fi
	fi

	return $pass
}

# =========================== Start from here ==============================
if [ $# -gt 0 ]; then
	para=$(echo $1 | tr [:upper:] [:lower:])
	case $para in
		"-onlyfw")
			start_index=$index_board_ver
			end_index=$index_fw
			check_fwver_flag=1
		;;
		"-onlycal")
			start_index=$index_cal
			end_index=$index_cal_hdr
		;;
		"-withcal")
			start_index=$index_board_ver
			end_index=$index_cal_hdr
		;;
		"-factory")
			start_index=$index_spi_hdr
			end_index=$index_fw
		;;
		*)
			echo "FAIL, Unknown parameter: $para"
			print_usage
			exit $para_fail
		;;
	esac
fi

echo "stop asic and then change spi path to qcom for updating asic firmware...."
set_fw_by_hw_ver
update_init
status=$?
if [ $status -ne $pass ]; then
	exit_update $status
fi

if [ $check_fwver_flag -eq 1 ]; then
	echo "check fw-version if need to update..."
	check_upgrade_required
	update_fw_flag=$?
fi
if [ $update_fw_flag -eq $chkfile_fail ]; then
	exit_update $update_fw_flag
else
	echo "fw-update-or-not:$update_fw_flag"
fi

echo "erase and then update with verifying....($start_index, $end_index)"
for i in $(seq $start_index $end_index)
do
	if [ $update_fw_flag -eq 0 ] && [ $i -eq $index_board_ver -o $i -eq $index_fw ]; then
		echo "No need update ${offset[$i]} due to the same"
		continue
	fi;

	update_one_part ${offset[$i]} ${length[$i]} ${files[$i]}
	status=$?
	if [ $status -ne $pass ]; then
		exit_update $status
	fi
done

echo "switch back the spi path to asic after updating...."
exit_update $pass

echo "Reset asic and wait $ddr_test_wait_sec sec for DDR Check"
echo $asic_pwr_on > $asic_pwr_ctrl
sleep $ddr_test_wait_sec
validate_fw_flash
result=$?

echo "After check, turn off asic...."
echo $asic_pwr_off > $asic_pwr_ctrl

if [ $result -ne $pass ]; then
	echo "Update firmware FAIL!!"
else
	echo "Update firmware SUCCESS!!"
fi
exit $result
