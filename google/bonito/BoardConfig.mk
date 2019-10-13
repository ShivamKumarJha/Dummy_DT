DEVICE_PATH := device/google/bonito
BOARD_VENDOR := google

# Security patch level
VENDOR_SECURITY_PATCH := 2019-10-05

# HIDL
DEVICE_MANIFEST_FILE := $(DEVICE_PATH)/manifest.xml
DEVICE_MANIFEST_FILE += $(DEVICE_PATH)/android.hardware.atrace@1.0-service.pixel.xml
DEVICE_MANIFEST_FILE += $(DEVICE_PATH)/android.hardware.cas@1.1-service.xml
DEVICE_MANIFEST_FILE += $(DEVICE_PATH)/android.hardware.power@1.3-service.pixel.xml
DEVICE_MANIFEST_FILE += $(DEVICE_PATH)/android.hardware.thermal@2.0-service.pixel.xml
DEVICE_MANIFEST_FILE += $(DEVICE_PATH)/manifest_android.hardware.health.storage@1.0.xml
DEVICE_MANIFEST_FILE += $(DEVICE_PATH)/manifest_wifi_ext.xml
DEVICE_MATRIX_FILE := $(DEVICE_PATH)/compatibility_matrix.xml
DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE := $(DEVICE_PATH)/framework_compatibility_matrix.xml

-include vendor/google/bonito/BoardConfigVendor.mk