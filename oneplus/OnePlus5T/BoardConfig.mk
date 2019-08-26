DEVICE_PATH := device/oneplus/OnePlus5T
BOARD_VENDOR := oneplus

# Security patch level
VENDOR_SECURITY_PATCH := 2019-08-01

# HIDL
DEVICE_MANIFEST_FILE := $(DEVICE_PATH)/manifest.xml
DEVICE_MATRIX_FILE := $(DEVICE_PATH)/compatibility_matrix.xml
DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE := $(DEVICE_PATH)/framework_compatibility_matrix.xml

-include vendor/oneplus/OnePlus5T/BoardConfigVendor.mk