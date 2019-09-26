DEVICE_PATH := device/coolpad/msm8909_512go
BOARD_VENDOR := coolpad

# HIDL
DEVICE_MANIFEST_FILE := $(DEVICE_PATH)/manifest.xml
DEVICE_MATRIX_FILE := $(DEVICE_PATH)/compatibility_matrix.xml

-include vendor/coolpad/msm8909_512go/BoardConfigVendor.mk