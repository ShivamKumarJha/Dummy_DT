#!/vendor/bin/sh
echo "booting vibration" > /dev/kmsg
i=0
while [ -e /proc/asound/card${i} ]
do
	card_id=`cat /proc/asound/card${i}/id`
	if [ "$card_id" == "sdm845tavilsndc" ]; then
		card=$i
		echo "get sound card $card" > /dev/kmsg
		break
	fi
	i=$(($i+1))
done
if [ -n "$card" ] ; then
	echo "play boot vibration" > /dev/kmsg
	sleep 1.9
	/system/bin/tinymix -D ${card} 'SEC_MI2S_RX Audio Mixer MultiMedia8' '1'
	/system/bin/tinyplay /vendor/etc/boot_vibrate.wav -D ${card} -d 17 -i 0
	sleep 0.5
	setprop 'sys.asus.boot_vibrate.completed' '1'
fi

#
#sleep 1.9
#/system/bin/tinymix 'SEC_MI2S_RX Audio Mixer MultiMedia8' '1'
#/system/bin/tinyplay /vendor/etc/boot_vibrate.wav -D 0 -d 17 -i 0
#sleep 0.5
#/system/bin/tinymix 'SEC_MI2S_RX Audio Mixer MultiMedia8' '0'
#setprop 'sys.asus.boot_vibrate.completed' '1'
