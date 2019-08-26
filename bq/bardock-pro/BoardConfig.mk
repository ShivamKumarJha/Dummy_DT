DEVICE_PATH := device/bq/bardock-pro
BOARD_VENDOR := bq

# HIDL
DEVICE_MANIFEST_FILE := $(DEVICE_PATH)/manifest.xml
DEVICE_MATRIX_FILE := $(DEVICE_PATH)/compatibility_matrix.xml

-include vendor/bq/bardock-pro/BoardConfigVendor.mk