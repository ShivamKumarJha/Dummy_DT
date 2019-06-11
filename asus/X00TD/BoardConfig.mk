DEVICE_PATH := device/asus/X00TD
BOARD_VENDOR := asus

# Security patch level
VENDOR_SECURITY_PATCH := 2019-05-01

# HIDL
DEVICE_MANIFEST_FILE := $(DEVICE_PATH)/manifest.xml
DEVICE_MATRIX_FILE := $(DEVICE_PATH)/compatibility_matrix.xml

-include vendor/asus/X00TD/BoardConfigVendor.mk