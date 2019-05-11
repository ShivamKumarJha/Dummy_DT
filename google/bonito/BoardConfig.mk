DEVICE_PATH := device/google/bonito
BOARD_VENDOR := google

# Security patch level
VENDOR_SECURITY_PATCH := 2019-03-05

# HIDL
DEVICE_MANIFEST_FILE := $(DEVICE_PATH)/manifest.xml
DEVICE_MATRIX_FILE := $(DEVICE_PATH)/compatibility_matrix.xml

-include vendor/google/bonito/BoardConfigVendor.mk