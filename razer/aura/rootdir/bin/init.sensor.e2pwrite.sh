#! /vendor/bin/sh

# Copyright (c) 2014, The Linux Foundation. All rights reserved.
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

E2P_ALS_PARTITION="/proc/sensordata/ALS"
ALS_REGISTRY_PATH="/mnt/vendor/persist/sensors/registry/registry"

if [ -e ${E2P_ALS_PARTITION} ]; then

  # Read raw E2P
  RAW_E2P=$(cat ${E2P_ALS_PARTITION})

  # Check E2P content
  if [ ${RAW_E2P} == "" ]; then
    echo "E2P content is null"
    exit
  fi
  OWNER=`echo ${RAW_E2P} | cut -d'"' -f4`
  if [ ${OWNER} != "owner" ] ; then
    echo "E2P content is invalid"
    exit
  fi

  # Get file path from E2P content
  FILE=`echo ${RAW_E2P} | cut -d'"' -f2`
  ALS_REGISTRY_FILE=${ALS_REGISTRY_PATH}/${FILE}
  echo "Registry file path=${ALS_REGISTRY_FILE}"

  # We wait for 10 seconds
  # Only copy file when ${ALS_REGISTRY_FILE} is exist
  i=0
  while [ "${i}" != "10" ]
  do
    echo "Loop ${i}"
    if [ -e "${ALS_REGISTRY_FILE}" ]; then
      RAW_PERSIST=$(cat ${ALS_REGISTRY_FILE})
      if [ "${RAW_E2P}" == "${RAW_PERSIST}" ]; then
        echo "Content matched"
        exit
      else
        echo "Copy E2P to ${ALS_REGISTRY_FILE}"
        echo ${RAW_E2P} > ${ALS_REGISTRY_FILE}
      fi
    fi
    sleep 1
    i=$(($i+1))
  done

  # If time out, we just copy the file
  echo "Time's out, copy E2P to ${ALS_REGISTRY_FILE}"
  echo ${RAW_E2P} > ${ALS_REGISTRY_FILE}
fi
