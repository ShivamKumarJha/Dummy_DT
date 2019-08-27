#! /vendor/bin/sh
pass=0
update_log="/data/vendor/asic/autoupdate.log"
result_prop="vendor.light.asic.autoupdate"
fwver_prop="vendor.camera.chromatix.versions.main"
update_cmd="update_asic_fw.sh -onlyfw"
asic_lcc_fw_version="lcc -m 0 -s 0 -r -p 00 00 04 02"
asic_pwr_ctrl=/sys/asic/link/asic_power
asic_pwr_on=1
asic_pwr_off=0
ddr_test_wait_sec=1
ver_array=""

validate_fw_flash()
{
	ver_string=$($asic_lcc_fw_version)
	result=$?
	if [ $result -eq $pass ]; then
		echo "DDR check Pass!!" >> $update_log
	else
		echo "DDR check Failed!!" >> $update_log
	fi
	echo fw-ver-array:$ver_string >> $update_log
	ver_array=($ver_string)
	return $result
}

exit_result()
{
	if [ $result -eq $pass ]; then
		build_id_hex=${ver_array[3]}${ver_array[2]}${ver_array[1]}${ver_array[0]}
		build_id=$((16#$build_id_hex))
		version=${ver_array[5]}${ver_array[4]}.${ver_array[7]}${ver_array[6]}.${ver_array[9]}${ver_array[8]}
	else
		build_id="N//A"
		version="N/A"
	fi
	setprop $fwver_prop "fw-ver:$version build-id:$build_id"
	setprop $result_prop $1
	exit $1
}

#==========================================================================
echo "auto-update-process start..." > $update_log
$update_cmd >> $update_log
result=$?
if [ $result -ne $pass ]; then
	echo "\nupdate fail, retry... $result" >> $update_log
	$update_cmd >> $update_log
	result=$?
	if [ $result -ne $pass ]; then
		echo "\nretry-update still fail... $result" >> $update_log
		exit_result $result
	fi
fi

echo "\n\nAfter reset asic, sleeping for $ddr_test_wait_sec sec for DDR Check" >> $update_log
echo $asic_pwr_on > $asic_pwr_ctrl
sleep $ddr_test_wait_sec
validate_fw_flash
result=$?

echo "Turning off ASIC" >> $update_log
echo $asic_pwr_off > $asic_pwr_ctrl

if [ $result -ne $pass ]; then
result=$(($result + 1000))
fi

exit_result $result
