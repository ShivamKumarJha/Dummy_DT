DEVICE_PATH := device/sony/keyaki_dsds
BOARD_VENDOR := sony

# HIDL
DEVICE_MANIFEST_FILE := $(DEVICE_PATH)/manifest.xml
DEVICE_MATRIX_FILE := $(DEVICE_PATH)/compatibility_matrix.xml

-include vendor/sony/keyaki_dsds/BoardConfigVendor.mk