LOCAL_PATH := $(call my-dir)
ifeq ($(TARGET_DEVICE),I001_1)
include $(call all-makefiles-under,$(LOCAL_PATH))
include $(CLEAR_VARS)
endif