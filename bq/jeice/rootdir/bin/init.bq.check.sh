#!/vendor/bin/sh

if [ -f /cache/bq_reset ]; then
	setprop persist.bq.reset 1
else
	setprop persist.bq.reset 0
fi
