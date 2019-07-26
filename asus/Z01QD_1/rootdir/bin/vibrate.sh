#!/vendor/bin/sh

echo "booting vibrator" > /dev/kmsg
/system/bin/tinymix "SEC_MI2S_RX Audio Mixer MultiMedia8" 1
/system/bin/tinyplay /vendor/etc/firmware/bootup_0628.wav -D 0 -d 17 -i 0
