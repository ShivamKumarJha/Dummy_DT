DEVICE_PATH := device/oneplus/OnePlus6
BOARD_VENDOR := oneplus

# Security patch level
VENDOR_SECURITY_PATCH := 2018-07-05

# HIDL
DEVICE_MANIFEST_FILE := $(DEVICE_PATH)/manifest.xml
DEVICE_MATRIX_FILE := $(DEVICE_PATH)/compatibility_matrix.xml

-include vendor/oneplus/OnePlus6/BoardConfigVendor.mk