#! /vendor/bin/sh

export PATH=/vendor/bin

echo "loopback test"
spk=1
rec=2
mic1=3
mic2=4
enable=1
disable=0
open="-Y"
close="-N"

if test $2 -eq $enable
then
	loopbacktest $open "$1"
elif test $2 -eq $disable
then
	loopbacktest $close "$1"
	setprop sys.loopback-spk 2
	setprop sys.loopback-rec 2
	setprop sys.loopback-mic1 2
	setprop sys.loopback-mic2 2
else
	echo "input error ctl cmd!"
fi
