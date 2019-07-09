DEVICE_PATH := device/xiaomi/andromeda
BOARD_VENDOR := xiaomi

# Security patch level
VENDOR_SECURITY_PATCH := 2019-05-05

# HIDL
DEVICE_MANIFEST_FILE := $(DEVICE_PATH)/manifest.xml
DEVICE_MANIFEST_FILE += $(DEVICE_PATH)/android.hardware.cas@1.1-service.xml
DEVICE_MATRIX_FILE := $(DEVICE_PATH)/compatibility_matrix.xml

-include vendor/xiaomi/andromeda/BoardConfigVendor.mk