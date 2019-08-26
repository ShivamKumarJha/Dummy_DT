#!/vendor/bin/sh
# *********************************************************************
# * Copyright 2014 (C) Sony Mobile Communications Inc.                *
# * All rights, including trade secret rights, reserved.              *
# *********************************************************************
#

#######################################################################
#
# Extension of init.usbmode.sh for platform.
# This script is called by init.usbmode.sh.
#
# Requested parameters
#   $1  action
#       eng_setup   do eng mode setup
#                   $2  USB_FUNCTION
#
# Exit value
#   0   specified setup is done.
#   1   specified setup is done nothing.
#
# Return value (available only when exit 0)
#   $PID $USB_FUNCTION
#
#######################################################################
#######################################################################
#
# Function of rndis_qc driver for platform.
# Requested parameters
#   $1  action
#       set_rndis_qc   do settings to use rndis_qc driver
#                      for each platforms.
#
# Exit value
#   0   settings for each platforms are done
#
#######################################################################

TAG="usb_platform"

# setup usb eng mode
setup_engmode()
{
  PID_PREFIX=0
  SUPPORT_RMNET=1
  case ${1} in
    "mass_storage,adb") PID_PREFIX=6 ;;
    "mtp,adb") PID_PREFIX=5 ;;
    "rndis,adb")
      PID_PREFIX=D
      SUPPORT_RMNET=0
      ;;
    *)
      /vendor/bin/log -t ${TAG} -p i "No eng PID for: ${1}"
      exit 1
      ;;
  esac

  PID=${PID_PREFIX}146
  USB_FUNCTION=${1},serial,diag
  echo diag > /sys/class/android_usb/android0/f_diag/clients
  echo char_bridge,tty > /sys/class/android_usb/android0/f_serial/transports
  if [ ${SUPPORT_RMNET} -eq 1 ] ; then
    USB_FUNCTION=${USB_FUNCTION},rmnet
    echo qti,bam2bam_ipa > /sys/class/android_usb/android0/f_rmnet/transports
  fi

  echo "${PID} ${USB_FUNCTION}"
  exit 0
}

set_rndis_qc()
{
  # Setting to use rndis_qc driver
  echo BAM2BAM_IPA > /sys/class/android_usb/android0/f_rndis_qc/rndis_transports
  echo 131072 > /sys/module/g_android/parameters/mtp_tx_req_len
  echo 131072 > /sys/module/g_android/parameters/mtp_rx_req_len
}

case ${1} in
  "eng_setup")
    if [ $# -ne 2 ] ; then
      exit 1
    fi

    setup_engmode ${2}
    ;;
  "set_rndis_qc")
    set_rndis_qc
    exit 0
    ;;
esac

exit 1
