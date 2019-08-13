#!/vendor/bin/sh
sleep 2
game_mode_type=`getprop sys.asus.gamingtype`
rotation_type=`getprop sys.screen.rotation`
rotate_enable= 1
echo "game_mode_type : $game_mode_type" > /dev/kmsg
echo "rotation_type : $rotation_type" > /dev/kmsg

echo $game_mode_type > sys/devices/platform/goodix_ts.0/game_mode
echo $rotation_type> sys/devices/platform/goodix_ts.0/rotation_type



