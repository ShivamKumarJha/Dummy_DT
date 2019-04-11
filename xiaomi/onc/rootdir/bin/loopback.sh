#! /system/bin/sh
echo "loopback test"
spk=1
rec=2
mic1=3
mic2=4
playback=5
enable=1
disable=0
open="-Y"
close="-N"
pname="tinyhostless"
pname_play="tinyplay"
pbname="loopbacktest"
loop_status=`getprop sys.loopback-status`

if test $2 -eq $enable
then
	echo "$loop_status"
	if [ "$loop_status"x = "1"x ]
	then
	while [ "$loop_status"x != "0"x ]
	do
		#echo "need wait loop status $loop_status"
		loop_status=`getprop sys.loopback-status`
	done
	fi
	loopbacktest $open "$1" 13
	if test $1 -eq $playback
	then
		echo "playback test!"
		#setprop sys.tinyplay 1
		tinyplay /vendor/etc/spk_pb.wav
	else
		if test $1 -eq $spk
		then
		#setprop sys.tinyhostless-spk 1
		setenforce 0
		start tinyhostless_spk
		else
		#setprop sys.tinyhostless 1
		setenforce 0
		start tinyhostless
		fi	
	fi
elif test $2 -eq $disable
then
	echo "$loop_status"
	if [ "$loop_status"x = "0"x ]
	then
	while [ "$loop_status"x != "1"x ]
	do
		#echo "need wait loop status $loop_status"
		loop_status=`getprop sys.loopback-status`
	done
	fi
	if test $1 -eq $playback
	then
	pkill -f $pbname
	pkill -f $pname_play
	setprop sys.spk-playback 2
	setprop sys.tinyplay 0
	loopbacktest $close "$1"
	else
	pkill -f $pname
	loopbacktest $close "$1"
	#setprop sys.tinyhostless 0
	#setprop sys.tinyhostless-spk 0
	stop tinyhostless
	stop tinyhostless_spk
	setprop sys.loopback-spk 2
	setprop sys.loopback-rec 2
	setprop sys.loopback-mic1 2
	setprop sys.loopback-mic2 2
	setenforce 1
	fi
else
	echo "input error ctl cmd!"
fi
