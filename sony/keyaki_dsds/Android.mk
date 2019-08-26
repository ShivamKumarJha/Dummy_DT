LOCAL_PATH := $(call my-dir)
ifeq ($(TARGET_DEVICE),keyaki_dsds)
include $(call all-makefiles-under,$(LOCAL_PATH))
include $(CLEAR_VARS)
endif