#!/system/bin/sh
FPver_ALG=`getprop goodix.version.alg`
FPver_PKG=`getprop goodix.version.pack`
FPver_PREP=`getprop goodix.version.prep`
FPver_NAV=`getprop goodix.version.nav`
FPver_BUILD=`getprop goodix.version.build`

FINAL_VER="$FPver_PKG"

setprop fp.version.driver "$FINAL_VER"
