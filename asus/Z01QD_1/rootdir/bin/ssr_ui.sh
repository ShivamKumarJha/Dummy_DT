#!/system/bin/sh

prop=`getprop persist.sys.modem.restart`
prop_subname=`getprop persist.sys.ssr.subname`
prop_substatus=`getprop persist.sys.ssr.substatus`

if [ "$prop_substatus" != "online" -a "$prop_substatus" != "offline" ] ; then
  echo "Wrong State : $prop_substatus"
  exit
fi

if [ $(($prop & 1)) -eq 1 ] ; then
  am start -a com.asus.ssr.ui --es name "$prop_subname" --es state "$prop_substatus" -n com.asus.eehui/.eehui &
fi

if [ "$prop_substatus" == "offline" ] ; then
  setprop persist.sys.ssr.substatus "ssr"
elif [ "$prop_substatus" == "online" ] ; then
  setprop persist.sys.ssr.substatus "done"
fi
