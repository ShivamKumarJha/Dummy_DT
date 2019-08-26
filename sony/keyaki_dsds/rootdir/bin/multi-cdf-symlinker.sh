#!/vendor/bin/sh

# Copyright (C) 2013 Sony Mobile Communications Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# NOTE: This file has been modified by Sony Mobile Communications Inc.
# Modifications are licensed under the License.

# Script to create symlinks depending on currently active configuration

active_customization="$(/vendor/bin/getprop ro.semc.version.cust.active)"
src_dir="/data/customization"
ota_dir="/data/customization/ota-config"

customized_filenames=""
customized_filenames+="clatd.conf "
customized_filenames+="extra-bootanimation.zip "
customized_filenames+="gps.conf "
customized_filenames+="shutdown.mp4 "
customized_filenames+="wpa_supplicant.conf "
customized_filenames+="default.playlist "
customized_filenames+="apns-conf.xml "
customized_filenames+="hotspot2.conf "
customized_filenames+="dpm.conf "
customized_filenames+="preset_networks.conf "

potential_prefixes="/data/customization/ota-config "
if [ -n "${active_customization}" ]; then
    potential_prefixes+="/oem/android-config/${active_customization} "
    potential_prefixes+="/system/etc/customization/settings/${active_customization} "
fi
potential_prefixes+="/oem/android-config "
potential_prefixes+="/system/etc/customization/settings/defaults "


for filename in ${customized_filenames}; do
    src="${src_dir}/${filename}"
    /vendor/bin/rm -f "$src"
    for prefix in ${potential_prefixes}; do
        dest="${prefix}/${filename}"
        if [ -e "${dest}" ]; then
            /vendor/bin/ln -s "${dest}" "${src}"
            continue 2 # on to the next filename
        fi
    done
done


# symlink the override profiles to profiles in oem
src_profiles_dir="/data/vendor/connectivity/wqeclient/profiles_override"
dest_profiles_dir="/oem/android-config/profiles/"
if [ -n "${active_customization}" ]; then
    if [ -e "/oem/android-config/${active_customization}/profiles/" ]; then
        dest_profiles_dir="/oem/android-config/${active_customization}/profiles/"
    fi
fi
if [ -e "${dest_profiles_dir}" ] ; then
    /vendor/bin/ln -s "${dest_profiles_dir}" "${src_profiles_dir}"
fi

