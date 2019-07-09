DEVICE_PATH := device/oneplus/fajita
BOARD_VENDOR := oneplus

# Security patch level
VENDOR_SECURITY_PATCH := 2019-05-05

# HIDL
DEVICE_MANIFEST_FILE := $(DEVICE_PATH)/manifest.xml
DEVICE_MANIFEST_FILE += $(DEVICE_PATH)/android.hardware.cas@1.1-service.xml
DEVICE_MATRIX_FILE := $(DEVICE_PATH)/compatibility_matrix.xml

-include vendor/oneplus/fajita/BoardConfigVendor.mk