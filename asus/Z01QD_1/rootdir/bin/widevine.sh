#!/vendor/bin/sh

/vendor/bin/is_keybox_valid
/vendor/bin/is_keymaster_valid
/system/bin/is_hdcp_valid

ret=$(/vendor/bin/hdcp2p2prov -verify)
if [ "${ret}" = "Verification succeeded. Device is provisioned." ]; then
	setprop "atd.hdcp2p2.ready" TRUE
else
	setprop "atd.hdcp2p2.ready" FALSE
fi

ret=$(/vendor/bin/hdcp1prov -verify)
if [ "${ret}" = "Verification succeeded. Device is provisioned." ]; then
	setprop "atd.hdcp1.ready" TRUE
else
	setprop "atd.hdcp1.ready" FALSE
fi


# start install_key_server
setprop "atd.start.key.install" 1
