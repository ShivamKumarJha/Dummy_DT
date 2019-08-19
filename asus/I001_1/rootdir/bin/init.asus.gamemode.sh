#!/vendor/bin/sh
game_mode_type=`getprop sys.asus.gamingtype`
echo "game_mode_type : $game_mode_type" > /dev/kmsg

echo $game_mode_type > sys/devices/platform/goodix_ts.0/game_mode



