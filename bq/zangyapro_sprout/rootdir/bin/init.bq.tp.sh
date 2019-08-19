function do_set_property_from_file()
{
	local ret_string
	local property=$2

	if [ -f $1 ]
	then
		ret_string=`cat $1`
		#remove space on string last
		ret_string=${ret_string%%" "}
		#replace space to "_"
		ret_string=${ret_string//" "/"_"}
	else
		ret_string="unknown"
	fi

	if [ $property != "" ]
	then
		setprop $property  $ret_string
	fi
	echo ${ret_string}

}

function set_property_from_file()
{
	do_set_property_from_file $1 "bq.product.$2"
}

set_property_from_file /sys/android_tp/tp_info "tp"
