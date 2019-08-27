#!/vendor/bin/sh

if [ "$1" == "" ] || [ $1 -eq 0 ]; then
	start_sensor=1
	end_sensor=5
elif [ $1 -ge 1 ] && [ $1 -le 5 ]; then
	start_sensor=$1
	end_sensor=$1
else
	echo "Wrong number: $input"
	echo "Usage: $0 [num]"
	echo "  num: 0~5(default:0), 0:all sensors, 1~5:one selected sensor"
	exit -1
fi

#reset asic
prog_app_p2 -q
sleep 10

last_addr=2058
read_bytes=16;
hex_size=$(printf "%02X" "$read_bytes")

for i in $(seq $start_sensor $end_sensor)
do
	offset=0
	sensor=$((1 << $i));
	hex_sensor=$(printf "%02X" "$sensor")
	dump_path=/data/camera/dump_eeprom_sensor$i.log
	echo "dump eeprom for sensor:$i [s:$sensor, h:0x$hex_sensor], dump:$dump_path"

	echo "sensor:$i, start_offset:$offset, length:$last_addr" > $dump_path
	#dump eeprom
	while [ $offset -le $last_addr ]; do
		low_byte=$(printf "%02X" "$(($offset & 255))")
		high_byte=$(printf "%02X" "$(($offset >> 8))")
		#echo "debug offset:$offset, low:$low_byte, high:$high_byte"
		printf "%08X: " "$offset" >> $dump_path
		/data/lcc -m 0 -s 0 -w -p 12 34 72 02 $hex_sensor 00 00 $low_byte $high_byte $hex_size 00
		/data/lcc -m 0 -s 0 -r -p 12 34 72 02 $hex_sensor 00 00 >> $dump_path
		offset=$(($offset + $read_bytes))
	done
done
