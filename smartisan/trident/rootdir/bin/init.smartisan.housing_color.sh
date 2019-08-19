#! /vendor/bin/sh

housing_color_file=/vendor/etc/housing-color.prop
factory_color=$(dd if=$(echo /dev/block/bootdevice/by-name/factory) count=20 bs=1 skip=49)

echo "housing.color $factory_color"

if  [ ! -e $housing_color_file -o -z $factory_color ]
then
    setprop ro.housing.color unknown
    exit 1
fi

while read -r line
do
#    echo $line
    if [ $line = ${factory_color:0:${#line}} ]
    then
        setprop ro.housing.color $line
        exit 1
    fi
done < $housing_color_file

#set default color unknown

setprop ro.housing.color unknown

exit 0
