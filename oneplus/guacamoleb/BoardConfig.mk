DEVICE_PATH := device/oneplus/guacamoleb
BOARD_VENDOR := oneplus

# Security patch level
VENDOR_SECURITY_PATCH := 2019-06-01

# HIDL
DEVICE_MANIFEST_FILE := $(DEVICE_PATH)/manifest.xml
DEVICE_MATRIX_FILE := $(DEVICE_PATH)/compatibility_matrix.xml

-include vendor/oneplus/guacamoleb/BoardConfigVendor.mk