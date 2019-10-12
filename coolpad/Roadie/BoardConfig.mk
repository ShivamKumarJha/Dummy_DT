DEVICE_PATH := device/coolpad/Roadie
BOARD_VENDOR := coolpad

# HIDL
DEVICE_MANIFEST_FILE := $(DEVICE_PATH)/manifest.xml
DEVICE_MATRIX_FILE := $(DEVICE_PATH)/compatibility_matrix.xml

-include vendor/coolpad/Roadie/BoardConfigVendor.mk