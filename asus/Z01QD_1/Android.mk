LOCAL_PATH := $(call my-dir)
ifeq ($(TARGET_DEVICE),Z01QD_1)
include $(call all-makefiles-under,$(LOCAL_PATH))
include $(CLEAR_VARS)
endif