DEVICE_PATH := device/bq/raditz_s
BOARD_VENDOR := bq

# HIDL
DEVICE_MANIFEST_FILE := $(DEVICE_PATH)/manifest.xml
DEVICE_MATRIX_FILE := $(DEVICE_PATH)/compatibility_matrix.xml

-include vendor/bq/raditz_s/BoardConfigVendor.mk