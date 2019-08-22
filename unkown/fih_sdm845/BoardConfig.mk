DEVICE_PATH := device/unkown/fih_sdm845
BOARD_VENDOR := unkown

# Security patch level
VENDOR_SECURITY_PATCH := 2019-08-01

# HIDL
DEVICE_MANIFEST_FILE := $(DEVICE_PATH)/manifest.xml
DEVICE_MATRIX_FILE := $(DEVICE_PATH)/compatibility_matrix.xml
DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE := $(DEVICE_PATH)/framework_compatibility_matrix.xml

-include vendor/unkown/fih_sdm845/BoardConfigVendor.mk