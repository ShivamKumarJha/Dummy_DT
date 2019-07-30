DEVICE_PATH := device/lenovo/heart
BOARD_VENDOR := lenovo

# Security patch level
VENDOR_SECURITY_PATCH := 2018-12-01

# HIDL
DEVICE_MANIFEST_FILE := $(DEVICE_PATH)/manifest.xml
DEVICE_MATRIX_FILE := $(DEVICE_PATH)/compatibility_matrix.xml
DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE := $(DEVICE_PATH)/framework_compatibility_matrix.xml

-include vendor/lenovo/heart/BoardConfigVendor.mk