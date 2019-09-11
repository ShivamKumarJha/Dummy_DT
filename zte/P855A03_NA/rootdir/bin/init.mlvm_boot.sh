#!/vendor/bin/sh
# Copyright (c) 2018 The Linux Foundation. All rights reserved.
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

# Commands to enable vblock0 for the MLVM configuration

export PATH=/vendor/bin
MLVM_TAG="MLVM_init"

if [ -d  /sys/vservices/server-sessions/microvisor:server.linux_mlvm ]; then
  #Below is to retrieve the dev block from the commandline
  vm_system_partition="$(grep -o 'vm_system=/dev/sda[0-9]*' /proc/cmdline | tail -1 | awk -F\/ '{print $3;}')"
  log -t ${MLVM_TAG} "Passing vm system fs to MLVM ($vm_system_partition)"
  echo $vm_system_partition > /sys/vservices/server-sessions/microvisor:server.linux_mlvm/core:0/create_service
  echo com.ok-labs.block > /sys/vservices/server-sessions/microvisor:server.linux_mlvm/${vm_system_partition}:1/protocol
  echo 1 > /sys/vservices/server-sessions/microvisor:server.linux_mlvm/${vm_system_partition}:1/start
  vm_ret=$?
  vm_retry_count=0
  while [ $vm_ret != 0 ]; do
    echo 1 > /sys/vservices/server-sessions/microvisor:server.linux_mlvm/${vm_system_partition}:1/start
    vm_ret=$?
    ((vm_retry_count++))
    if [ $vm_retry_count == 20 ]; then
       break
    fi
  done
  if [ $vm_ret != 0 ]; then
     log -t ${MLVM_TAG} "Could not bring MLVM FS up"
  else
     log -t ${MLVM_TAG} "MLVM FS is up"
  fi
fi
