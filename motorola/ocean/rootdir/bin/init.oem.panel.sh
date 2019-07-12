#!/vendor/bin/sh

PATH=/sbin:/vendor/sbin:/vendor/bin:/vendor/xbin
export PATH

while getopts s: op;
do
	case $op in
		s)  supplier=$OPTARG;;
	esac
done
shift $(($OPTIND-1))

scriptname=${0##*/}

notice()
{
	echo "$*"
	echo "$scriptname: $*" > /dev/kmsg
}

notice "panel supplier is [$supplier]"
case $supplier in
	ofilm)
		insmod /vendor/lib/modules/focaltech_mmi.ko
		;;
	tianma)
		insmod /vendor/lib/modules/ilitek_mmi.ko
		;;
	csot)
		insmod /vendor/lib/modules/nova_mmi.ko
		;;
	*)
		notice "$supplier not supported"
		return 1
		;;
esac

return 0