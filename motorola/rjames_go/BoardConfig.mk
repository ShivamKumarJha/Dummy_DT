DEVICE_PATH := device/motorola/rjames_go
BOARD_VENDOR := motorola

# HIDL
DEVICE_MANIFEST_FILE := $(DEVICE_PATH)/manifest.xml
DEVICE_MATRIX_FILE := $(DEVICE_PATH)/compatibility_matrix.xml

-include vendor/motorola/rjames_go/BoardConfigVendor.mk