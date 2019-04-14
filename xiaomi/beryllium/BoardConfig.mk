DEVICE_PATH := device/xiaomi/beryllium
BOARD_VENDOR := xiaomi

# Security patch level
VENDOR_SECURITY_PATCH := =2019-04-01

# HIDL
DEVICE_MANIFEST_FILE := $(DEVICE_PATH)/manifest.xml
DEVICE_MATRIX_FILE := $(DEVICE_PATH)/compatibility_matrix.xml

-include vendor/xiaomi/beryllium/BoardConfigVendor.mk