DEVICE_PATH := device/nubia/NX629J
BOARD_VENDOR := nubia

# Security patch level
VENDOR_SECURITY_PATCH := 2019-03-05

# HIDL
DEVICE_MANIFEST_FILE := $(DEVICE_PATH)/manifest.xml
DEVICE_MATRIX_FILE := $(DEVICE_PATH)/compatibility_matrix.xml

-include vendor/nubia/NX629J/BoardConfigVendor.mk