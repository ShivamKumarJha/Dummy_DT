#!/system/bin/sh
file_path="/data/logs/back_partition.log"

now_time=`date +%y%m%d%H%M%S | busybox awk '{print $1}'`

echo "time: $now_time" >$file_path

st1=/dev/block/bootdevice/by-name/modemst1
st2=/dev/block/bootdevice/by-name/modemst2
fsg1=/dev/block/bootdevice/by-name/fsg1
fsg2=/dev/block/bootdevice/by-name/fsg2

hash_st1=`sha1sum $st1 | busybox awk '{print $1}'`
hash_st2=`sha1sum $st2 | busybox awk '{print $1}'`

echo "hash_st1 $hash_st1" >>$file_path 2>>$file_path
echo "hash_st2 $hash_st2" >>$file_path 2>>$file_path

for i in `seq 3`
do
    dd if=$st1 of=$fsg1 bs=4096 count=512 >>$file_path 2>>$file_path
    dd if=$st2 of=$fsg2 bs=4096 count=512 >>$file_path 2>>$file_path

    hash_fsg1=`sha1sum $fsg1 | busybox awk '{print $1}'`
    hash_fsg2=`sha1sum $fsg2 | busybox awk '{print $1}'`

    echo "hash_fsg1 $hash_fsg1" >>$file_path 2>>$file_path
    echo "hash_fsg2 $hash_fsg2" >>$file_path 2>>$file_path

    if [ "${hash_fsg1}" == "${hash_st1}"  -a  "${hash_fsg2}" == "${hash_st2}" ]
    then
        echo "Success" | tee -a $file_path
        exit 0
    else
        echo "Try again $i times ..." >>$file_path 2>>$file_path
    fi
done

echo "Fail" | tee -a $file_path

exit 1