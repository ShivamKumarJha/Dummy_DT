export PATH=/vendor/bin

if [ -f /sys/fp_id/fp_id ]; then
    fp_module=`cat /sys/fp_id/fp_id` 2> /dev/null
    setprop persist.sys.fptype "$fp_module"
    setprop sys.fingerprint.boot "$fp_module"
    isUD=`echo "$fp_module" | grep "^udfp_"`
    if [ "$isUD" != "" ];then
        setprop persist.vivo.fingerprint.front "true"
    fi
    isDoubleFinger=`echo "$fp_module" | grep ","`
    if [ "$isDoubleFinger" != "" ];then
        setprop sys.fingerprint.double "true"
        OLD_IFS="$IFS"
        IFS=","
        fp_arr=($fp_module);
        for fp_name in ${fp_arr[@]}
        do
            ud=`echo "$fp_name" | grep "^udfp_"`
            if [ "$ud" != "" ];then
                setprop sys.fingerprint.ud "$fp_name"
            else
                setprop sys.fingerprint.back "$fp_name"
            fi
        done
        IFS="$OLD_IFS"
    fi

fi
