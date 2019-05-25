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
#PATH=/sbin:/system/sbin:/system/bin:/system/xbin
#export PATH
export PATH=/vendor/bin

THERMAL_LINK=`getprop sys.create.thermal_link`

if [ "$THERMAL_LINK" == "1" ]; then
	#ASUS_BSP +++ Show_Cai create symbolic link to vadc                                                                                                    
	SOC_PATH="/sys/devices/soc/"
	SEARCH_ASUS_SKIN_THERM="asus_skin_therm"                             
	SEARCH_TOP_CENTER="asus_top_center_therm"
	SEARCH_BOT_CENTER="asus_bot_center_therm"
	SEARCH_PA_THERM="asus_pa_therm"
	SEARCH_PA_THERM1="asus_pa_therm1"
	SEARCH_DIE_TEMP="asus_die_temp"
	SEARCH_SKIN_TEMP="in_temp_skin_temp_input" 

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
	therm_check $SEARCH_ASUS_SKIN_THERM "/dev/therm/vadc/asus_skin_temp"
	therm_check $SEARCH_TOP_CENTER "/dev/therm/vadc/asus_top_center_temp"
	therm_check $SEARCH_BOT_CENTER "/dev/therm/vadc/asus_bot_center_temp"
	therm_check $SEARCH_PA_THERM "/dev/therm/vadc/asus_pa_temp"
	therm_check $SEARCH_PA_THERM1 "/dev/therm/vadc/asus_pa_temp1"
	therm_check $SEARCH_DIE_TEMP "/dev/therm/vadc/asus_die_temp"
	therm_check $SEARCH_SKIN_TEMP "/dev/therm/vadc/skin_temp"                   

	ln -s /dev/therm/vadc/asus_skin_temp /dev/therm/vadc/msm_therm                                                                         
	#ASUS_BSP --- Show_Cai create symbolic link to vadc  

	#ASUS_BSP +++ Show_Cai create symbolic link for run-in test
	ln -s /system/vendor/bin/thermalAtdTool /data/data/Thermal
	sleep 10
	#ASUS_BSP --- Show_Cai creat symbolic link for run-in test
	setprop sys.create.thermal_link 0
fi

THERMAL_RESET=`getprop sys.thermal_engine.reset`
if [ "$THERMAL_RESET" == "1" ]; then
	stop thermal-engine
	start thermal-engine
	setprop sys.thermal_engine.reset 0
fi

SNS_DUMP=`getprop sys.thermal.dumpsys_sns`
if [ "$SNS_DUMP" == "1" ]; then
	/vendor/bin/sns_dump_pm
	setprop sys.thermal.dumpsys_sns 0
fi

#platform=`getprop ro.boot.id.prj`
#if [ $platform == "5" ]; then
#	ln -s /system/etc/firmware/sdm660/cppf.b00 /data/data/cppf.b00
#	ln -s /system/etc/firmware/sdm660/cppf.b01 /data/data/cppf.b01
#	ln -s /system/etc/firmware/sdm660/cppf.b02 /data/data/cppf.b02
#	ln -s /system/etc/firmware/sdm660/cppf.b03 /data/data/cppf.b03
#	ln -s /system/etc/firmware/sdm660/cppf.b04 /data/data/cppf.b04
#	ln -s /system/etc/firmware/sdm660/cppf.b05 /data/data/cppf.b05
#	ln -s /system/etc/firmware/sdm660/cppf.b06 /data/data/cppf.b06
#	ln -s /system/etc/firmware/sdm660/cppf.b07 /data/data/cppf.b07
#	ln -s /system/etc/firmware/sdm660/cppf.mdt /data/data/cppf.mdt

#	ln -s /system/etc/firmware/sdm660/widevine.b00 /data/data/widevine.b00
#	ln -s /system/etc/firmware/sdm660/widevine.b01 /data/data/widevine.b01
#	ln -s /system/etc/firmware/sdm660/widevine.b02 /data/data/widevine.b02
#	ln -s /system/etc/firmware/sdm660/widevine.b03 /data/data/widevine.b03
#	ln -s /system/etc/firmware/sdm660/widevine.b04 /data/data/widevine.b04
#	ln -s /system/etc/firmware/sdm660/widevine.b05 /data/data/widevine.b05
#	ln -s /system/etc/firmware/sdm660/widevine.b06 /data/data/widevine.b06
#	ln -s /system/etc/firmware/sdm660/widevine.b07 /data/data/widevine.b07
#	ln -s /system/etc/firmware/sdm660/widevine.mdt /data/data/widevine.mdt
	
#	ln -s /system/etc/firmware/sdm660/dxhdcp2.b00 /data/data/dxhdcp2.b00
#	ln -s /system/etc/firmware/sdm660/dxhdcp2.b01 /data/data/dxhdcp2.b01
#	ln -s /system/etc/firmware/sdm660/dxhdcp2.b02 /data/data/dxhdcp2.b02
#	ln -s /system/etc/firmware/sdm660/dxhdcp2.b03 /data/data/dxhdcp2.b03
#	ln -s /system/etc/firmware/sdm660/dxhdcp2.b04 /data/data/dxhdcp2.b04
#	ln -s /system/etc/firmware/sdm660/dxhdcp2.b05 /data/data/dxhdcp2.b05
#	ln -s /system/etc/firmware/sdm660/dxhdcp2.b06 /data/data/dxhdcp2.b06
#	ln -s /system/etc/firmware/sdm660/dxhdcp2.b07 /data/data/dxhdcp2.b07
#	ln -s /system/etc/firmware/sdm660/dxhdcp2.mdt /data/data/dxhdcp2.mdt
#	echo "sdm660"
#else
#	ln -s /system/etc/firmware/sdm630/cppf.b00 /data/data/cppf.b00
#	ln -s /system/etc/firmware/sdm630/cppf.b01 /data/data/cppf.b01
#	ln -s /system/etc/firmware/sdm630/cppf.b02 /data/data/cppf.b02
#	ln -s /system/etc/firmware/sdm630/cppf.b03 /data/data/cppf.b03
#	ln -s /system/etc/firmware/sdm630/cppf.b04 /data/data/cppf.b04
#	ln -s /system/etc/firmware/sdm630/cppf.b05 /data/data/cppf.b05
#	ln -s /system/etc/firmware/sdm630/cppf.b06 /data/data/cppf.b06
#	ln -s /system/etc/firmware/sdm630/cppf.b07 /data/data/cppf.b07
#	ln -s /system/etc/firmware/sdm630/cppf.mdt /data/data/cppf.mdt

#	ln -s /system/etc/firmware/sdm630/widevine.b00 /data/data/widevine.b00
#	ln -s /system/etc/firmware/sdm630/widevine.b01 /data/data/widevine.b01
#	ln -s /system/etc/firmware/sdm630/widevine.b02 /data/data/widevine.b02
#	ln -s /system/etc/firmware/sdm630/widevine.b03 /data/data/widevine.b03
#	ln -s /system/etc/firmware/sdm630/widevine.b04 /data/data/widevine.b04
#	ln -s /system/etc/firmware/sdm630/widevine.b05 /data/data/widevine.b05
#	ln -s /system/etc/firmware/sdm630/widevine.b06 /data/data/widevine.b06
#	ln -s /system/etc/firmware/sdm630/widevine.b07 /data/data/widevine.b07
#	ln -s /system/etc/firmware/sdm630/widevine.mdt /data/data/widevine.mdt
	
#	ln -s /system/etc/firmware/sdm630/dxhdcp2.b00 /data/data/dxhdcp2.b00
#	ln -s /system/etc/firmware/sdm630/dxhdcp2.b01 /data/data/dxhdcp2.b01
#	ln -s /system/etc/firmware/sdm630/dxhdcp2.b02 /data/data/dxhdcp2.b02
#	ln -s /system/etc/firmware/sdm630/dxhdcp2.b03 /data/data/dxhdcp2.b03
#	ln -s /system/etc/firmware/sdm630/dxhdcp2.b04 /data/data/dxhdcp2.b04
#	ln -s /system/etc/firmware/sdm630/dxhdcp2.b05 /data/data/dxhdcp2.b05
#	ln -s /system/etc/firmware/sdm630/dxhdcp2.b06 /data/data/dxhdcp2.b06
#	ln -s /system/etc/firmware/sdm630/dxhdcp2.b07 /data/data/dxhdcp2.b07
#	ln -s /system/etc/firmware/sdm630/dxhdcp2.mdt /data/data/dxhdcp2.mdt
#	echo "sdm630"
#fi
