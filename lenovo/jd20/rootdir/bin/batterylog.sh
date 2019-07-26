#!/vendor/bin/sh

######################################################################
# 0             1    2      3           4         5           6           7       8            9
# batterylog.sh date uptime output_file dumper_en dumper_flag prop_length log_cnt record_count pause_time
######################################################################
# Version  Date        Author         Description
# 11	   2018-11-05  Lenovo         Make new battery log tool

VER=11

if [ -n "$1" ] && [ -n "$2" ] && [ -n "$3" ] && [ -n "$4" ] && [ -n "$5" ] && [ -n "$6" ] && [ -n "$7" ] && [ -n "$8" ] && [ -n "$9" ]; then
    bc_time="$1"
    bc_uptime="$2"
    out_file="$3"
    out_dumper="$3.qc"
    tmp_file="$3.tmp"
    dumper_en="$4"
    dumper_flag="$5"
    raw_prop_len="$6"
    log_cnt="$7"
    rec_cnt="$8"
    pause_time="$9"
else
    exit
fi

product=""
platform=""
cpu_num=0
no_len=0
cpu_buf=""
local utime
local ktime

get_product() {
    a=`getprop|grep ro.product.name`
    b=`echo ${a##*\[}`
    product=`echo ${b%]*}`
}

get_platform() {
    a=`getprop|grep ro.board.platform`
    b=`echo ${a##*\[}`
    platform=`echo ${b%]*}`
}
get_product
get_platform

# GPU PATH
if [[ "$platform" == "sdm710" ]]; then
    GPU_CUR_PATH="/sys/class/kgsl/kgsl-3d0/gpuclk"
    GPU_MAX_PATH="/sys/class/kgsl/kgsl-3d0/max_gpuclk"
elif [[ "$platform" == "msmnile" ]]; then
    GPU_CUR_PATH="/sys/devices/platform/soc/*.qcom,kgsl-3d0/kgsl/kgsl-3d0/gpuclk"
    GPU_MAX_PATH="/sys/devices/platform/soc/*.qcom,kgsl-3d0/kgsl/kgsl-3d0/max_gpuclk"
else
    GPU_CUR_PATH="/sys/devices/soc/*.qcom,kgsl-3d0/kgsl/kgsl-3d0/gpuclk"
    GPU_MAX_PATH="/sys/devices/soc/*.qcom,kgsl-3d0/kgsl/kgsl-3d0/max_gpuclk"
fi

# CPU PATH
CPU_PATH="/sys/devices/system/cpu/"
PRF_CPU_CUR_PATH="/d/clk/perfcl_clk/clk_measure"
PWR_CPU_CUR_PATH="/d/clk/pwrcl_clk/clk_measure"
if [[ "$platform" == "sdm710" ]]; then
    PRF_CPU_MAX_PATH="/sys/devices/platform/soc/*.qcom,cpucc/*.qcom,cpucc:qcom,limits-dcvs@1/lmh_freq_limit"
    PWR_CPU_MAX_PATH="/sys/devices/platform/soc/*.qcom,cpucc/*.qcom,cpucc:qcom,limits-dcvs@0/lmh_freq_limit"
elif [[ "$platform" == "msmnile" ]]; then
    PRF_CPU_MAX_PATH="/sys/devices/platform/soc/*.qcom,cpucc/*.qcom,cpucc:qcom,limits-dcvs@18350800/lmh_freq_limit"
    PWR_CPU_MAX_PATH="/sys/devices/platform/soc/*.qcom,cpucc/*.qcom,cpucc:qcom,limits-dcvs@18358800/lmh_freq_limit"
    PRF_P_CPU_CUR_PATH="/d/clk/perfpcl_clk/clk_measure"
fi

# Charge Pump
CHARGE_DUMP_EN_PATH="/sys/class/charge_pump/enable"
CHARGE_DUMP_DIE_TEMP_PATH="/sys/class/charge_pump/die_temp"
CHARGE_DUMP_ISNS_PATH="/sys/class/charge_pump/isns"
CHARGE_DUMP_STAT1_PATH="/sys/class/charge_pump/stat1"
CHARGE_DUMP_STAT2_PATH="/sys/class/charge_pump/stat2"

# Backlight PATH
BACKLIGHT_PATH="/sys/class/backlight/panel0-backlight/brightness"

# Thermal PATH
THERMAL_ZONE_PATH="/sys/devices/virtual/thermal"

get_charge_pump_prop() {
    if [[ "$product" == "zippo" ]]; then
	prop="pump_en,pump_die_temp,pump_isns,pump_stat1,pump_stat2"
    else
	prop=""
    fi
}

get_charge_pump_value() {
    local p1=
    if [[ "$product" == "zippo" ]]; then
	p1=" "${CHARGE_DUMP_EN_PATH}
	p1+=" "${CHARGE_DUMP_DIE_TEMP_PATH}
	p1+=" "${CHARGE_DUMP_ISNS_PATH}
	p1+=" "${CHARGE_DUMP_STAT1_PATH}
	p1+=" "${CHARGE_DUMP_STAT2_PATH}
	value=`cat $p1 | tr '\n' ','`
	value=`echo ${value%,*}`
    else
	value=""
    fi
}

get_cpu_max_num() {
    cpu_num=`cat ${CPU_PATH}/kernel_max`
    i=0
    cpu_buf=
    if [[ "$platform" == "sdm710" ]]; then
	cpu_buf="perf_cur,pwr_cur,perf_max,pwr_max"
    elif [[ "$platform" == "msmnile" ]]; then
        cpu_buf="perf_cur,perfp_cur,pwr_cur,perf_max,pwr_max"
    else
	while true
	do
            if [ $i -gt $cpu_num ]; then
		break
            fi
            cpu_buf=${cpu_buf}",cpu${i}_max"
	    let i=${i}+1
	done

	i=0
	while true
	do
            if [ $i -gt $cpu_num ]; then
		break
	    fi
            cpu_buf=${cpu_buf}",cpu${i}_cur"
	    let i=${i}+1
	done
    fi
}
get_cpu_max_num

get_cooling_dev_prop() {
    local p1=
    for dir in $(ls ${THERMAL_ZONE_PATH})
    do
        if [[ "$dir" == "cooling_device"* ]] && [ -r ${THERMAL_ZONE_PATH}/"$dir/cur_state" ]; then
            a=`cat ${THERMAL_ZONE_PATH}/${dir}/type`
	    # WR for sdm710 modem devices
	    if [[ "$platform" == "sdm710" ]] && [[ "$a" == "modem_"* ]]; then
		continue
	    else
		p1+=$a","
	    fi
        fi
    done
    prop=$p1
    prop=`echo ${prop%,*}`

    # WR for sdm710 modem devices
    if [[ "$platform" == "sdm710" ]]; then
	prop+=",modem_pa,modem_proc,modem_vdd,modem_current"
   fi
}

# WR for sdm710 modem devices
sdm710_modem_pa_path=${tmp_file}
sdm710_modem_proc_path=${tmp_file}
sdm710_modem_vdd_path=${tmp_file}
sdm710_modem_modem_current=${tmp_file}

get_cooling_dev_value() {
    local p1=
    echo -1 >${tmp_file}
    for dir in $(ls ${THERMAL_ZONE_PATH})
    do
        if [[ "$dir" == "cooling_device"* ]] && [ -r ${THERMAL_ZONE_PATH}/"$dir/cur_state" ]; then
            a=`cat ${THERMAL_ZONE_PATH}/${dir}/type`
	    # WR for sdm710 modem devices
	    if [[ "$platform" == "sdm710" ]]; then
                if [[ "$a" == "modem_pa" ]]; then
                    sdm710_modem_pa_path=${THERMAL_ZONE_PATH}/${dir}/cur_state
                elif [[ "$a" == "modem_proc" ]]; then
                    sdm710_modem_proc_path=${THERMAL_ZONE_PATH}/${dir}/cur_state
                elif [[ "$a" == "modem_vdd" ]]; then
                    sdm710_modem_vdd_path=${THERMAL_ZONE_PATH}/${dir}/cur_state
                elif [[ "$a" == "modem_current" ]]; then
                    sdm710_modem_modem_current=${THERMAL_ZONE_PATH}/${dir}/cur_state
                else
                    p1+=" "${THERMAL_ZONE_PATH}/${dir}/cur_state
                fi
	    else
	        p1+=" "${THERMAL_ZONE_PATH}/${dir}/cur_state
	    fi
        fi
    done

    # WR for sdm710 modem devices
    if [[ "$platform" == "sdm710" ]]; then
	p1+=" "${sdm710_modem_pa_path}
	p1+=" "${sdm710_modem_proc_path}
	p1+=" "${sdm710_modem_vdd_path}
	p1+=" "${sdm710_modem_modem_current}
    fi
    value=`cat $p1 | tr '\n' ','`
    value=`echo ${value%,*}`
    rm $tmp_file
}

get_value_len() {
    local arr
    OLD_IFS="$IFS"
    IFS=$','
    arr=($value)
    echo ${#arr[@]}
    IFS=$OLD_IFS
}

get_cpu_value() {
    local p1=
    local i=0
    echo -1 >${tmp_file}
    if [ -r "${CPU_PATH}/online" ]; then
	p1=${CPU_PATH}/online
    else
	p1=-${tmp_file}
    fi

    if [[ "$platform" == "sdm710" ]] || [[ "$platform" == "msmnile" ]]; then
	if [ -r ${PRF_CPU_CUR_PATH} ]; then
	    p1+=" "${PRF_CPU_CUR_PATH}
	else
	    p1+=" "$tmp_file
	fi

	if [[ "$platform" == "msmnile" ]]; then
	    if [ -r ${PRF_P_CPU_CUR_PATH} ]; then
		p1+=" "${PRF_P_CPU_CUR_PATH}
	    else
		p1+=" "$tmp_file
	    fi
	fi

	if [ -r ${PWR_CPU_CUR_PATH} ]; then
	    p1+=" "${PWR_CPU_CUR_PATH}
	else
	    p1+=" "$tmp_file
	fi

	if [ -r ${PRF_CPU_MAX_PATH} ]; then
	    p1+=" "${PRF_CPU_MAX_PATH}
	else
	    p1+=" "$tmp_file
	fi

	if [ -r ${PWR_CPU_MAX_PATH} ]; then
	    p1+=" "${PWR_CPU_MAX_PATH}
	else
	    p1+=" "$tmp_file
	fi
    else
	while [ $i -le ${cpu_num} ]
	do
	    if [ -r "${CPU_PATH}/cpu$i/cpufreq/scaling_max_freq" ]; then
		p1+=" "${CPU_PATH}/cpu$i/cpufreq/scaling_max_freq
	    else
		p1+=" "$tmp_file
	    fi
	    i=$(($i+1))
	done

	i=0
	while [ $i -le ${cpu_num} ]
	do
	    if [ -r "${CPU_PATH}/cpu$i/cpufreq/scaling_cur_freq" ]; then
		p1+=" "${CPU_PATH}/cpu$i/cpufreq/scaling_cur_freq
	    else
		p1+=" "$tmp_file
	    fi
	    i=$(($i+1))
	done
    fi

    value=`cat $p1  | tr '\n' ','`
    value=`echo ${value%,*}`
    rm $tmp_file
}

get_gpu_value() {
    local p1=
    echo -1 >$tmp_file

    if [ -r ${GPU_CUR_PATH} ]; then
	p1+=${GPU_CUR_PATH}
    else
	p1+=${tmp_file}
    fi

    if [ -r ${GPU_MAX_PATH} ]; then
	p1+=" "${GPU_MAX_PATH}
    else
	p1+=" "${tmp_file}
    fi

    value=`cat $p1  | tr '\n' ','`
    value=`echo ${value%,*}`
    rm $tmp_file
}

get_backlight_value() {
    local p1=
    echo -1 >$tmp_file

    if [ -r ${BACKLIGHT_PATH} ]; then
	p1+=${BACKLIGHT_PATH}
    else
	p1+=${tmp_file}
    fi

    value=`cat $p1  | tr '\n' ','`
    value=`echo ${value%,*}`
    rm $tmp_file
}

get_ps_prop() {
    local a b arr i
    a=`cat $1`
    b=""
    OLD_IFS="$IFS"
    IFS=$'\n'
    arr=($a)
    for i in ${arr[@]}
    do
	# WR for charger_temp
	if [[ "$1" == "/sys/class/power_supply/battery/uevent" ]] && [[ "${i}" == *"CHARGER_TEMP="* ]]; then
	    continue
	fi
        c=${i%=*}
        b=$b"${c:13},"
    done

    IFS=$OLD_IFS
    prop=`echo $(echo $b | tr '[A-Z]' '[a-z]')`
    prop=`echo ${prop%,*}`
    # WR for charger_temp
    if [[ "$1" == "/sys/class/power_supply/battery/uevent" ]]; then
	prop=${prop},charger_temp
    fi
    IFS=$OLD_IFS
}

get_ps_value() {
    local a arr i
    a=`cat $1`
    value=""
    OLD_IFS="$IFS"
    IFS=$'\n'
    arr=($a)
    for i in ${arr[@]}
    do
	# WR for charger_temp
	if [[ "$1" == "/sys/class/power_supply/battery/uevent" ]] && [[ "${i}" == *"CHARGER_TEMP="* ]]; then
	    continue
	fi
        value+=${i#*=}","
    done;

    # WR for charger_temp
    if [[ "$1" == "/sys/class/power_supply/battery/uevent" ]]; then
	if [ -r /sys/class/power_supply/battery/charger_temp ]; then
	    a=`cat /sys/class/power_supply/battery/charger_temp`
	    if [ $? -eq 0 ]; then
		value+=$a,
	    else
		value+=-1,
	    fi
	else
	    value+=-1,
	fi
    fi

    IFS=$OLD_IFS
    value=`echo ${value%,*}`
}

get_new_prop() {
    local prop_arr raw_prop_arr i j
    OLD_IFS="$IFS"
    IFS=","
    prop_arr=($prop)
    raw_prop_arr=($raw_prop)
    IFS="$OLD_IFS"

    for i in ${prop_arr[@]}
    do
	if [[ "$1" == "" ]]; then
	    raw_prop="$raw_prop"",""$i"
	else
	    raw_prop="$raw_prop"",$1""_$i"
	fi
    done
    return ${#prop_arr[@]}
}

get_virtual_value() {
    local v=
    local i=1
    while true
    do
        if [ $i -lt $1 ]; then
            v=",""$v"
            i=$(($i+1))
        else
            break
        fi
    done
    echo "$v"
}

dump_peripheral () {
    local base=$1
    local size=$2
    local dump_path=$3
    echo $base > $dump_path/address
    echo $size > $dump_path/count
    value=`cat $dump_path/data`
}

dump_smbchg_fg_regs () {
    echo $1 >$2
    value=`cat $2`
}

build_dumper_log() {
    if [ ! -s $out_dumper ] || [ ! -e $out_dumper ]; then
        qc_buf="Starting dumps!""\n"
        qc_buf="$qc_buf""Dump path = $dump_path, pause time = $pause_time""\n"
    fi
	utime=($(cat /proc/uptime))
	ktime=${utime[0]}
	qc_buf+="System Time is ${bc_time}\n"
	qc_buf+="FG SRAM Dump Started at ${ktime}\n"
	dump_peripheral 0 $1 "/sys/kernel/debug/fg/sram"
	qc_buf+="$value\n"
	uptime=($(cat /proc/uptime))
	ktime=${utime[0]}
	qc_buf+="FG SRAM Dump done at ${ktime}"
    echo "$qc_buf" >>$out_dumper
}

prop_list=("battery" "bms" "usb" "main" "pc_port" "cpu" "gpu" "backlight" "charge_pump" "cooling_dev" "temp" )
type_list=(0          0    0     0      0         1     1     1           1             1             1      )

build_battery_log() {
    if [ ! -s $out_file ] || [ ! -e $out_file ]; then
        raw_prop="time,uptime,version,log_cnt,rec_cnt,platform,product"

	index=0
	for name in ${prop_list[@]}
	do
	    if [ ${type_list[$index]} -eq 0 ]; then
		if [ -f /sys/class/power_supply/${prop_list[$index]}/uevent ]; then
		    get_ps_prop "/sys/class/power_supply/${prop_list[$index]}/uevent"
		    get_new_prop ${prop_list[$index]}
		    len=$?
		    if [ $index -eq 0 ]; then
			raw_prop_len=${len}
		    else
			raw_prop_len=${raw_prop_len},${len}
		    fi
		fi
	    else
		if [ ${prop_list[$index]} == "cpu" ]; then
		    prop="online,${cpu_buf}"
		elif [ ${prop_list[$index]} == "gpu" ]; then
		    prop="gpu_clk,gpu_max"
		elif [ ${prop_list[$index]} == "backlight" ]; then
		    prop="backlight"
		elif [ ${prop_list[$index]} == "cooling_dev" ]; then
		    get_cooling_dev_prop
		elif [ ${prop_list[$index]} == "charge_pump" ]; then
		    get_charge_pump_prop
		else
		    prop=""
		fi
	        get_new_prop ""
	        raw_prop_len=${raw_prop_len},$?
	    fi
	    let index=${index}+1
	done

        echo "$raw_prop" >$out_file

	OLD_IFS="$IFS"
	IFS=$','
	arr=($raw_prop_len)
	IFS=$OLD_IFS
    else
        if [[ "$raw_prop_len" == "0" ]]; then
            no_len=1
        else
            OLD_IFS="$IFS"
            IFS=$','
            arr=($raw_prop_len)
            IFS=$OLD_IFS

            for i in ${arr[@]}
            do
                if [[ ${arr[i]} == *[!0-9]* ]]; then
                    no_len=1
                    break
                fi
            done
        fi
    fi

    raw_value="$bc_time,$bc_uptime,$VER,$log_cnt,$rec_cnt,${platform},${product}"

    if [ $no_len -eq 1 ]; then
        echo $raw_value >>$out_file
        return
    fi

    index=0
    for name in ${prop_list[@]}
    do
        if [ ${type_list[$index]} -eq 0 ]; then
	    if [ -f /sys/class/power_supply/${prop_list[$index]}/uevent ]; then
                get_ps_value "/sys/class/power_supply/${prop_list[$index]}/uevent"
	    fi
	else
	    if [ ${prop_list[$index]} == "cpu" ]; then
                get_cpu_value
	    elif [ ${prop_list[$index]} == "gpu" ]; then
		get_gpu_value
	    elif [ ${prop_list[$index]} == "backlight" ]; then
	        get_backlight_value
	    elif [ ${prop_list[$index]} == "cooling_dev" ]; then
	        get_cooling_dev_value
	    elif [ ${prop_list[$index]} == "charge_pump" ]; then
	        get_charge_pump_value
	    elif [ ${arr[$index]} -eq 0 ]; then
	        continue
	    fi
        fi

        if [[ `get_value_len` -eq ${arr[$index]} ]]; then
	    raw_value="$raw_value"",$value"
        else
	    raw_value="$raw_value"",`get_virtual_value ${arr[$index]}`"
	fi
	let index=${index}+1
    done

    echo $raw_value >>$out_file
}

build_battery_log
if [[ $dumper_en -eq 1 ]]; then
    if [[ "$platform" == "sdm710" ]]; then
	build_dumper_log 500
    elif [[ "$platform" == "msmnile" ]]; then
	build_dumper_log 960
    else
        echo "" >>$out_dumper
    fi
fi
echo "prop_len=[""$raw_prop_len""]=prop_len"
