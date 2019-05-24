DEVICE_PATH := device/vivo/PD1821
BOARD_VENDOR := vivo

# Security patch level
VENDOR_SECURITY_PATCH := 2018-12-01

# HIDL
DEVICE_MANIFEST_FILE := $(DEVICE_PATH)/manifest.xml
DEVICE_MATRIX_FILE := $(DEVICE_PATH)/compatibility_matrix.xml

-include vendor/vivo/PD1821/BoardConfigVendor.mk