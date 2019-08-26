DEVICE_PATH := device/bq/nappa_s
BOARD_VENDOR := bq

# HIDL
DEVICE_MANIFEST_FILE := $(DEVICE_PATH)/manifest.xml
DEVICE_MATRIX_FILE := $(DEVICE_PATH)/compatibility_matrix.xml

-include vendor/bq/nappa_s/BoardConfigVendor.mk