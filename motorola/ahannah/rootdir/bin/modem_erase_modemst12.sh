#!/system/bin/sh

/system/bin/dd of=/dev/block/bootdevice/by-name/modemst1 if=/dev/zero
/system/bin/dd of=/dev/block/bootdevice/by-name/modemst2 if=/dev/zero
