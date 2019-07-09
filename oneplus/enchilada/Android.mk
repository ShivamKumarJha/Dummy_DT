LOCAL_PATH := $(call my-dir)
ifeq ($(TARGET_DEVICE),enchilada)
include $(call all-makefiles-under,$(LOCAL_PATH))
include $(CLEAR_VARS)
endif