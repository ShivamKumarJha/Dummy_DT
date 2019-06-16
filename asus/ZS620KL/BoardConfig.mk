DEVICE_PATH := device/asus/ZS620KL
BOARD_VENDOR := asus

# Security patch level
VENDOR_SECURITY_PATCH := 2019-05-05

# HIDL
DEVICE_MANIFEST_FILE := $(DEVICE_PATH)/manifest.xml
DEVICE_MATRIX_FILE := $(DEVICE_PATH)/compatibility_matrix.xml

-include vendor/asus/ZS620KL/BoardConfigVendor.mk