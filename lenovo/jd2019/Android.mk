LOCAL_PATH := $(call my-dir)
ifeq ($(TARGET_DEVICE),jd2019)
include $(call all-makefiles-under,$(LOCAL_PATH))
include $(CLEAR_VARS)
endif