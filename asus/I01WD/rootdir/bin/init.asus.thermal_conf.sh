#!/vendor/bin/sh
# Copyright (c) 2012-2013, The Linux Foundation. All rights reserved.
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
#

# No path is set up at this point so we have to do it here.
export PATH=/vendor/bin

THERMAL_LINK1=`getprop debug.create.thermal_link`
#THERMAL_LINK2=`getprop vendor.create.thermal_link`
#THERMAL_LINK3=`getprop persist.create.thermal_link`
#THERMAL_LINK=`getprop sys.create.thermal_link`
if [ "$THERMAL_LINK1" == "1" ]; then
	#ASUS_BSP +++ Show_Cai create symbolic link to vadc                                                                                                    
	SOC_PATH="/sys/devices/platform/soc/"
	SEARCH_MSM_THERM_TEMP="in_temp_skin_msm_therm_input"
	SEARCH_SKIN_TEMP="in_temp_skin_therm_input"

	SEARCH_PA_THERM1="in_temp_pa_therm1_input" 
	SEARCH_PA_THERM2="in_temp_pa_therm2_input"
	SEARCH_XO_THERM="in_temp_xo_therm_input"
	SEARCH_8150_DIE_TEMP="/sys/devices/platform/soc/c440000.qcom,spmi/spmi-0/spmi0-00/c440000.qcom,spmi:qcom,pm8150@0:vadc@3100/iio:device0/in_temp_die_temp_input"
	SEARCH_8150L_DIE_TEMP="/sys/devices/platform/soc/c440000.qcom,spmi/spmi-0/spmi0-04/c440000.qcom,spmi:qcom,pm8150l@4:vadc@3100/iio:device2/in_temp_die_temp_input"
	SEARCH_8150B_DIE_TEMP="/sys/devices/platform/soc/c440000.qcom,spmi/spmi-0/spmi0-02/c440000.qcom,spmi:qcom,pm8150b@2:vadc@3100/iio:device1/in_temp_die_temp_input"
	SEARCH_CHG_TEMP="in_temp_chg_temp_input"
	SEARCH_WP_THERM="in_temp_wp_therm_input"
	SEARCH_SMB1390_THERM="in_temp_smb1390_therm_input"
	SEARCH_SMB1355_THERM="in_temp_smb1355_therm_input"
	SEARCH_CAMEAR_FLASH_THERM="in_temp_camera_flash_therm_input"
	therm_check(){
		THERM_FILE=`find $SOC_PATH -name $1`
		if [ -f "$THERM_FILE" ]; then
			ln -s $THERM_FILE $2
			echo "[Thermal] link '$1' to '$2'"
		else
			echo "[Thermal] '$1' not found!!"
		fi
	}
	mkdir -p "/dev/therm/"                                                     
	chmod 755 "/dev/therm/"                                                   
	mkdir -p "/dev/therm/vadc"                                                
	chmod 755 "/dev/therm/vadc"
	therm_check $SEARCH_MSM_THERM_TEMP "/dev/therm/vadc/skin_msm_therm"
	therm_check $SEARCH_SKIN_TEMP "/dev/therm/vadc/skin_therm"
	therm_check $SEARCH_PA_THERM1 "/dev/therm/vadc/pa_therm1"
	therm_check $SEARCH_PA_THERM2 "/dev/therm/vadc/pa_therm2"
#	therm_check $SEARCH_SPEAKER_THERM "/dev/therm/vadc/asus_speaker_therm"
#	therm_check $SEARCH_QUIET_THERM "/dev/therm/vadc/PMI8998_quiet_therm"
	therm_check $SEARCH_XO_THERM "/dev/therm/vadc/xo_therm"
	therm_check $SEARCH_CHG_TEMP "/dev/therm/vadc/chg_temp"
	therm_check $SEARCH_WP_THERM "/dev/therm/vadc/wp_therm"
	therm_check $SEARCH_SMB1390_THERM "/dev/therm/vadc/smb1390_therm"
	therm_check $SEARCH_SMB1355_THERM "/dev/therm/vadc/smb1355_therm"
	therm_check $SEARCH_CAMEAR_FLASH_THERM "/dev/therm/vadc/camera_flash_therm"
	ln -s $SEARCH_8150_DIE_TEMP "8150_die_temp"
	ln -s $SEARCH_8150L_DIE_TEMP "8150l_die_temp"
	ln -s $SEARCH_8150B_DIE_TEMP "8150b_die_temp"

	#ASUS_BSP +++ Clay create symbolic link for run-in test
	ln -s /vendor/bin/thermalAtdTool /data/data/Thermal
	#ASUS_BSP --- Clay creat symbolic link for run-in test
	#setprop debug.create.thermal_link 0
	stop thermal-engine
	start thermal-engine
	#setprop debug.thermal_engine.reset 0
	setprop vendor.thermal.create_link_done 1
fi

GET_FREQ=`getprop debug.lmh`
if [ "$GET_FREQ" == "1" ]; then
    lmh1=`cat /sys/bus/platform/devices/18321000.qcom,cpucc:qcom,limits-dcvs@18350800/lmh_freq_limit`
    lmh0=`cat /sys/bus/platform/devices/18321000.qcom,cpucc:qcom,limits-dcvs@18358800/lmh_freq_limit`
    setprop vendor.thermal.lmh_freq0 $lmh0
    setprop vendor.thermal.lmh_freq1 $lmh1
fi

SNS_DUMP=`getprop sys.thermal.dumpsys_sns`
if [ "$SNS_DUMP" == "1" ]; then
    /vendor/bin/sns_dump_pm
    setprop sys.thermal.dumpsys_sns 0
fi
