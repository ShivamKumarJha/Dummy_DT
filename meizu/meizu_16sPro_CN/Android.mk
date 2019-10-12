LOCAL_PATH := $(call my-dir)
ifeq ($(TARGET_DEVICE),meizu_16sPro_CN)
include $(call all-makefiles-under,$(LOCAL_PATH))
include $(CLEAR_VARS)
endif