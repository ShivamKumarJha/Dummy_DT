LOCAL_PATH := $(call my-dir)
ifeq ($(TARGET_DEVICE),chef_sprout)
include $(call all-makefiles-under,$(LOCAL_PATH))
include $(CLEAR_VARS)
endif