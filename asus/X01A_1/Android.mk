LOCAL_PATH := $(call my-dir)
ifeq ($(TARGET_DEVICE),X01A_1)
include $(call all-makefiles-under,$(LOCAL_PATH))
include $(CLEAR_VARS)
endif