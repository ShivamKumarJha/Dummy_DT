#!/vendor/bin/sh
# Copyright (c) 2015,2018 The Linux Foundation. All rights reserved.
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

#
# Function to start sensors for SSC enabled platforms
#
start_sensors()
{
    sscrpcd_status=`getprop init.svc.vendor.sensors`

    chmod 755 /mnt/vendor/persist/sensors

    if [ ! -s /mnt/vendor/persist/sensors/sensors_settings ]; then
        # If the settings file is empty, enable sensors HAL
        # Otherwise leave the file with it's current contents
        touch /mnt/vendor/persist/sensors/sensors_settings
        chcon u:object_r:sensors_persist_file:s0 /mnt/vendor/persist/sensors/sensors_settings
        chmod 664 /mnt/vendor/persist/sensors/sensors_settings
    fi

    if [ ! -f /mnt/vendor/persist/sensors/sensors_registry ]; then
        # If the sensors_registry file is not here, create it
        # Otherwise leave the file with it's current contents
        touch /mnt/vendor/persist/sensors/sensors_registry
        chcon u:object_r:sensors_persist_file:s0 /mnt/vendor/persist/sensors/sensors_registry
        chmod 664 /mnt/vendor/persist/sensors/sensors_registry
    fi

    chown -h -R system.system /mnt/vendor/persist/sensors
    start vendor.sensors.qti

    # Only for SLPI
    if [ -c /dev/msm_dsps -o -c /dev/sensors ] && [ -z "$sscrpcd_status" ]; then
        start vendor.sensors
    fi

    sleep 0.05
    stop vendor.sensors-hal-1-0
    sleep 0.05
    start vendor.sensors-hal-1-0
}

start_sensors
