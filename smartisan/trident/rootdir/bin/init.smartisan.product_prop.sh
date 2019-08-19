#! /vendor/bin/sh

#SMARTISAN_BEGIN (CCM4006: change shell script to load modem prop)
#2017-12-27 cuipengfei: add script to load modem prop. M0215476

version_id_file=/sys/hwinfo/version_id

modem_prop_file="/vendor/etc/smartisan-modem.prop"

#echo "product_prop_file:$product_prop_file"
#echo "modem_prop_file:$modem_prop_file"

set_prop_func()
{
	while read -r line
	do
		#echo $line
		if [ "${line:0:1}" = "#" ] || [ "${line:0:1}" = "" ]
		then
		    continue
		fi
		setprop ${line%=*} ${line#*=}

	done < $1
}

if [ -f "$modem_prop_file" ]
then
	set_prop_func $modem_prop_file
else
	echo "Not found $modem_prop_file"
fi

if [ -e "$version_id_file" ]
then
	product_id=$(cat $version_id_file | sed -r 's/.*=(...):.*/\1/')
	product_prop_file="/vendor/etc/smartisan-$product_id.prop"

	if [ -f "$product_prop_file" ]
	then
		set_prop_func $product_prop_file
	else
		echo "Not found $product_prop_file"
		exit 1
	fi
else
	echo "Not found $version_id_file"
	exit 1
fi

exit 0
#SMARTISAN_END (CCM4006: change shell script to load modem prop)
