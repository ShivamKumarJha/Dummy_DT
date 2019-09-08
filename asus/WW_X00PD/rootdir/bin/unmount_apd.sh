#!/vendor/bin/sh

# This service is for ASUS Product Demo
umount /APD
# We chown/chmod /ADF again so because mount is run as root + defaults
chown -R system:system /ADF
chmod -R 0775 /ADF