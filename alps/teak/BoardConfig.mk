DEVICE_PATH := device/alps/teak
BOARD_VENDOR := alps

# HIDL
DEVICE_MANIFEST_FILE := $(DEVICE_PATH)/manifest.xml
DEVICE_MATRIX_FILE := $(DEVICE_PATH)/compatibility_matrix.xml

-include vendor/alps/teak/BoardConfigVendor.mk