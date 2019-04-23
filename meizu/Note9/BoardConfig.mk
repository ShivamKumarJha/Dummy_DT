DEVICE_PATH := device/meizu/Note9
BOARD_VENDOR := meizu

# Security patch level
VENDOR_SECURITY_PATCH := 2018-12-01

# HIDL
DEVICE_MANIFEST_FILE := $(DEVICE_PATH)/manifest.xml
DEVICE_MATRIX_FILE := $(DEVICE_PATH)/compatibility_matrix.xml

-include vendor/meizu/Note9/BoardConfigVendor.mk