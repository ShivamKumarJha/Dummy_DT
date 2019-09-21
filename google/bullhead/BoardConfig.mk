DEVICE_PATH := device/google/bullhead
BOARD_VENDOR := google

# HIDL
DEVICE_MANIFEST_FILE := $(DEVICE_PATH)/manifest.xml
DEVICE_MATRIX_FILE := $(DEVICE_PATH)/compatibility_matrix.xml

-include vendor/google/bullhead/BoardConfigVendor.mk