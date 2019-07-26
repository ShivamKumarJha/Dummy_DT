DEVICE_PATH := device/lenovo/jd20
BOARD_VENDOR := lenovo

# Security patch level
VENDOR_SECURITY_PATCH := 2019-05-01

# HIDL
DEVICE_MANIFEST_FILE := $(DEVICE_PATH)/manifest.xml
DEVICE_MATRIX_FILE := $(DEVICE_PATH)/compatibility_matrix.xml
DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE := $(DEVICE_PATH)/framework_compatibility_matrix.xml

-include vendor/lenovo/jd20/BoardConfigVendor.mk