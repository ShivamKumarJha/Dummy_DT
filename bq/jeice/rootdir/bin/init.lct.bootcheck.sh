#!/vendor/bin/sh
# Copyright (c) 2015, Longcheer. All rights reserved.
#

first_boot=`getprop persist.sys.first_boot`
if [ "$first_boot" == "" ]; then
    setprop persist.sys.first_boot true
else
if [ "$first_boot" == "true" ]; then
    setprop persist.sys.first_boot false
fi
fi
