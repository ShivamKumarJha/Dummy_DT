LOCAL_PATH := $(call my-dir)
ifeq ($(TARGET_DEVICE),J8110)
include $(call all-makefiles-under,$(LOCAL_PATH))
include $(CLEAR_VARS)
endif