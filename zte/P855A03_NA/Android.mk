LOCAL_PATH := $(call my-dir)
ifeq ($(TARGET_DEVICE),P855A03_NA)
include $(call all-makefiles-under,$(LOCAL_PATH))
include $(CLEAR_VARS)
endif