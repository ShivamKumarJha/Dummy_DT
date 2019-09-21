DEVICE_PATH := device/bq/jeice
BOARD_VENDOR := bq

# HIDL
DEVICE_MANIFEST_FILE := $(DEVICE_PATH)/manifest.xml
DEVICE_MATRIX_FILE := $(DEVICE_PATH)/compatibility_matrix.xml

-include vendor/bq/jeice/BoardConfigVendor.mk