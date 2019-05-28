DEVICE_PATH := device/xiaomi/davinci
BOARD_VENDOR := xiaomi

# Security patch level
VENDOR_SECURITY_PATCH := 2019-05-01

# HIDL
DEVICE_MANIFEST_FILE := $(DEVICE_PATH)/manifest.xml
DEVICE_MATRIX_FILE := $(DEVICE_PATH)/compatibility_matrix.xml

-include vendor/xiaomi/davinci/BoardConfigVendor.mk