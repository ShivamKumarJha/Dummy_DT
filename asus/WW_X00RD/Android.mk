LOCAL_PATH := $(call my-dir)
ifeq ($(TARGET_DEVICE),WW_X00RD)
include $(call all-makefiles-under,$(LOCAL_PATH))
include $(CLEAR_VARS)
endif