#! /vendor/bin/sh

# Copyright (c) 2010-2013, The Linux Foundation. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above
#       copyright notice, this list of conditions and the following
#       disclaimer in the documentation and/or other materials provided
#       with the distribution.
#     * Neither the name of The Linux Foundation nor the names of its
#       contributors may be used to endorse or promote products derived
#       from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESS OR IMPLIED
# WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT
# ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS
# BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
# BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
# OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
# IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#

E2P_ALS_PARTITION="/dev/block/platform/soc/1d84000.ufshc/by-name/mfd"
TEMP="/mnt/vendor/persist/sensors/registry/registry/mfd"
REGISTRY="/mnt/vendor/persist/sensors/registry/registry/cm36686_0_platform.ambient_light.fac_cal"

chown root:root /mnt/vendor/persist/sensors/registry/registry/

dd if=$E2P_ALS_PARTITION of=$TEMP bs=1 skip=491520 count=170

SENSOR=`cat $TEMP | cut -d'"' -f6`

if [ $SENSOR = "sns_cm36686" ]; then
   mv $TEMP $REGISTRY
   chown system:system $REGISTRY
else
   rm $TEMP
fi

chown system:system /mnt/vendor/persist/sensors/registry/registry/
