#!/system/bin/sh
am start -a android.intent.action.MAIN --ei repeat 3 --ei interrupt 1 --ei repeate_of_each_key 1 --es code "up,down,left,right" com.mitvirtester.duokan.mitvirtester/com.mitvirtester.duokan.mitvirtester.MainActivity   
sleep 10
am force-stop com.mitvirtester.duokan.mitvirtester 