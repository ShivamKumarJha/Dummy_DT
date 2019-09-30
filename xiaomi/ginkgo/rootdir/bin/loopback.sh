#! /system/bin/sh
#echo "loopback test"
spk=1
rec=2
mic1=3
mic2=4
playback=5
enable=1
disable=0
open="-Y"
close="-N"
pname_play="tinyplay"
pbname="loopbacktest"
loop_status=`getprop sys.loopback-status`

if test $2 -eq $enable
then
	loopbacktest $open "$1" 13
	if test $1 -eq $playback
	then
		echo "playback test!"
	else
		if test $1 -eq $spk
		then
		#setprop sys.tinyhostless-spk 1
		start tinyhostless_spk
		else
		start tinyhostless_loop
		fi
	fi
elif test $2 -eq $disable
then
	if test $1 -eq $playback
	then
	pkill -f $pbname
	loopbacktest $close "$1"
	else
	#pkill -f $pname
	loopbacktest $close "$1"
	stop tinyhostless_spk
	stop tinyhostless_loop
	fi
else
	echo "input error ctl cmd!"
fi
