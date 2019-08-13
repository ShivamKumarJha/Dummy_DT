#!/system/bin/sh

fig=/vendor/factory/attestation.flg
if [ -e "$fig" ]; then
	rm /vendor/factory/attestation.flg
fi
#temp=`/vendor/bin/KmInstallKeybox /vendor/factory/key.xml auto true`
/vendor/odm/bin/UpdateAttestationKey &> /dev/null
ret=`cat /vendor/factory/attestation.flg`
if [ "$ret" == "OK" ]; then
  echo "1"
else
  echo "0"
fi

