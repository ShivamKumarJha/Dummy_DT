#!/system/bin/sh

echo "PCBID TEST: +++"

rm /data/data/pcbid_status_str_tmp

PROP_STAGE=$(getprop ro.boot.id.stage)
PROP_PROJECT=$(getprop ro.boot.id.prj)

STAGE=
PROJECT=

case $PROP_PROJECT in
	"6" )
		PROJECT='ZS600KL'
		echo "PCBID TEST: PROJECT="$PROJECT
		;;
	*)
		PROJECT='UNKNOW('$PROP_PROJECT')'
		echo "PCBID TEST: PROJECT="$PROJECT
		;;
esac

case $PROP_STAGE in
	"0" )
		STAGE='SR1EVB'
		echo "PCBID TEST: STAGE="$STAGE
		;;
	"1" )
		STAGE='PROTO'
		echo "PCBID TEST: STAGE="$STAGE
		;;
	"2" )
		STAGE='SR1'
		echo "PCBID TEST: STAGE="$STAGE
		;;
	"3" )
		STAGE='SR2'
		echo "PCBID TEST: STAGE="$STAGE
		;;
	"4" )
		STAGE='ER1'
		echo "PCBID TEST: STAGE="$STAGE
		;;
	"5" )
		STAGE='ERAC'
		echo "PCBID TEST: STAGE="$STAGE
		;;
        "6" )
                STAGE='PR1'
                echo "PCBID TEST: STAGE="$STAGE
                ;;
        "7" )
                STAGE='MP'
                echo "PCBID TEST: STAGE="$STAGE
                ;;
	*)
		STAGE='UNKNOW('$PROP_STAGE')'
		echo "PCBID TEST: STAGE="$STAGE
		;;
esac

echo $PROJECT"_"$STAGE > /data/data/pcbid_status_str_tmp
chmod 00777 /data/data/pcbid_status_str_tmp

echo "PCBID TEST: ---"
