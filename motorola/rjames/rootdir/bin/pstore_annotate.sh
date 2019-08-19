#!/vendor/bin/sh
#
# Copyright (c) 2016, Motorola Mobility LLC,  All rights reserved.
#
# The purpose of this script is to annotate panic dumps with useful information
# about the context of the event.
#

export PATH=/vendor/bin:$PATH

annotate()
{
    VAL=`$2`
    [ "$VAL" ] || return

    echo "$1: $VAL" > /sys/fs/pstore/annotate-ramoops-0
}

case $1 in
    build*)
        annotate "Build product" "getprop ro.mot.build.system.product"
        annotate "Build number" "getprop ro.build.thumbprint"
        ;;
    baseband*)
        annotate "Baseband version" "getprop gsm.version.baseband"
        ;;
esac
