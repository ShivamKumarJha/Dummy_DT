LOCAL_PATH := $(call my-dir)
ifeq ($(TARGET_DEVICE),rjames_go)
include $(call all-makefiles-under,$(LOCAL_PATH))
include $(CLEAR_VARS)
endif