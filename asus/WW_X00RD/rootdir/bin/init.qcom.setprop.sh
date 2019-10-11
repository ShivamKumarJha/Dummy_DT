#! /vendor/bin/sh

# Copyright (c) 2012-2013,2016,2018 The Linux Foundation. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above copyright
#       notice, this list of conditions and the following disclaimer in the
#       documentation and/or other materials provided with the distribution.
#     * Neither the name of The Linux Foundation nor
#       the names of its contributors may be used to endorse or promote
#       products derived from this software without specific prior written
#       permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NON-INFRINGEMENT ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
# OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
# OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
# ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#

export PATH=/vendor/bin

# Set platform variables
if [ -f /sys/devices/soc0/hw_platform ]; then
    soc_hwplatform=`cat /sys/devices/soc0/hw_platform` 2> /dev/null
else
    soc_hwplatform=`cat /sys/devices/system/soc/soc0/hw_platform` 2> /dev/null
fi
if [ -f /sys/devices/soc0/soc_id ]; then
    soc_hwid=`cat /sys/devices/soc0/soc_id` 2> /dev/null
else
    soc_hwid=`cat /sys/devices/system/soc/soc0/id` 2> /dev/null
fi

target=`getprop ro.board.platform`
case "$target" in
    "msm8937" | "msm8940")
        # Set vendor.opengles.version based on chip id.
        # MSM8937 and MSM8940  variants supports OpenGLES 3.1
        # 196608 is decimal for 0x30000 to report version 3.0
        # 196609 is decimal for 0x30001 to report version 3.1
        # 196610 is decimal for 0x30002 to report version 3.2
        case "$soc_hwid" in
            294|295|296|297|298|313|353|354|363|364)
                if [ $soc_hwid = 313 ]; then
                    setprop ro.product.board MSM8940
                else
                    setprop ro.product.board MSM8937
                fi

                setprop vendor.opengles.version 196610

                if [ $soc_hwid = 354 ]
                then
                    setprop vendor.media.msm8937.version 1
                    log -t BOOT -p i "SDM429 early_boot prop set for: HwID '$soc_hwid'"
                fi
                case "$soc_hwplatform" in
                     "Surf")
                                  setprop qemu.hw.mainkeys 0
                                  ;;
                     "MTP")
                                  setprop qemu.hw.mainkeys 0
                                  ;;
                     "RCM")
                                  setprop qemu.hw.mainkeys 0
                                  ;;
                     "QRD")
                                  setprop qemu.hw.mainkeys 0
                                  ;;
                esac
                ;;
            303|307|308|309|320)
                # Vulkan is not supported for 8917 variants
                setprop vendor.opengles.version 196608
                setprop persist.graphics.vulkan.disable true

                setprop ro.product.board MSM8917
                case "$soc_hwplatform" in
                     "Surf")
                                  setprop qemu.hw.mainkeys 0
                                  ;;
                     "MTP")
                                  setprop qemu.hw.mainkeys 0
                                  ;;
                     "RCM")
                                  setprop qemu.hw.mainkeys 0
                                  ;;
                     "QRD")
                                  setprop qemu.hw.mainkeys 0
                                  ;;
                esac
                ;;
            *)
                setprop vendor.opengles.version 196608
                ;;
        esac
        ;;
esac
