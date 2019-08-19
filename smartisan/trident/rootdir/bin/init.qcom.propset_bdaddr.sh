#! /vendor/bin/sh
bdaddr=`cat /persist/bd_addr.txt`
setprop net.bluetooth.macaddr $bdaddr
