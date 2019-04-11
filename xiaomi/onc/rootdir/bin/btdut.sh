#!/vendor/bin/sh
vendor/bin/btconfig /dev/smd3 rawcmd 0x03 0x0003 &
	sleep 0.4
vendor/bin/btconfig /dev/smd3 rawcmd 0x06 0x0003 &
	sleep 0.4
vendor/bin/btconfig /dev/smd3 rawcmd 0x03 0x0005 0x02 0x00 0x02 &
	sleep 0.4
vendor/bin/btconfig /dev/smd3 rawcmd 0x03 0x001A 0x03 &
	sleep 0.4
vendor/bin/btconfig /dev/smd3 rawcmd 0x03 0x0020 0x00 &
	sleep 0.4
vendor/bin/btconfig /dev/smd3 rawcmd 0x03 0x0022 0x00 &
exit 0
