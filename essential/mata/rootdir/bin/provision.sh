#!/vendor/bin/sh


echo "provision values" $widevine_result $attestation_result &> /dev/kmsg

if [  ! -e "/persist/provision/att_serial" ]; then

	/vendor/bin/kb_parser

	if [ -e "/persist/provision/keybox.bin" ]; then
		StoreKeybox /persist/provision/keybox.out | tee /persist/provision/prov_wv &> /dev/kmsg
	fi


	if [ -e "/persist/provision/Attestation" ]; then
		serial=`cat /persist/provision/att_serial`
		LD_LIBRARY_PATH=/vendor/lib64/hw KmInstallKeybox /persist/provision/Attestation ${serial} false | tee /persist/provision/prov_att &> /dev/kmsg
	fi

	if [ -e "/persist/provision/hdcp1_enc.pem" ]; then
		hdcp1prov /persist/provision/hdcp1_enc.pem /persist/provision/DPS_hdcp1 | tee /persist/provision/prov_hdcp1
	fi

	if [ -e "/persist/provision/DPS_hdcp2" ]; then
		hdcp2p2prov /persist/provision/hdcp2_enc.pem /persist/provision/DPS_hdcp2 | tee /persist/provision/prov_hdcp2
	fi

	chmod 444 /persist/provision/prov_att
	chmod 444 /persist/provision/prov_wv
	chmod 444 /persist/provision/prov_hdcp1
	chmod 444 /persist/provision/prov_hdcp2
	rm /persist/provision/keybox.bin
	rm /persist/provision/Attestation
	rm /persist/provision/hdcp1_enc.pem
	rm /persist/provision/hdcp2_enc.pem
	rm /persist/provision/DPS_hdcp2
	rm /persist/provision/DPS_hdcp1
	rm /persist/provision/keybox.out

	echo "done" > "/persist/provision/prov"
fi

if [  ! -e "/persist/provision/clean" ]; then

	rm /persist/provision/keybox.bin
	rm /persist/provision/Attestation
	rm /persist/provision/hdcp1_enc.pem
	rm /persist/provision/hdcp2_enc.pem
	rm /persist/provision/DPS_hdcp2
	rm /persist/provision/DPS_hdcp1
	rm /persist/provision/keybox.out

	echo "done" > "/persist/provision/clean"
fi
