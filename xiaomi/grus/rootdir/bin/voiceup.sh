echo index=4 value=0x802200C0 > /sys/class/voicep/dbmdx/va_cfg_values
echo va > /sys/class/voicep/dbmdx/reboot
echo 1 > /sys/class/voicep/dbmdx/va_load_amodel
tinycap /data/voiceup.wav -D 1 -d 0 -c 2 -r 16000 -b 16 -t 5
