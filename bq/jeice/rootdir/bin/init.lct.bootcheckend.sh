#!/vendor/bin/sh
# Copyright (c) 2015, Longcheer. All rights reserved.
#

first_boot=`getprop persist.sys.first_boot`
if [ "$first_boot" == "true" ]; then
    setprop persist.sys.first_boot complete
    LctReadWriteNV 7243 1
else
if [ "$first_boot" == "false" ]; then
    setprop persist.sys.first_boot interrupt
    LctReadWriteNV 7243 1
fi
fi
