# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Lineage stuff
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from blueline device
$(call inherit-product, $(LOCAL_PATH)/device.mk)

PRODUCT_BRAND := google
PRODUCT_DEVICE := blueline
PRODUCT_MANUFACTURER := google
PRODUCT_NAME := lineage_blueline
PRODUCT_MODEL := mainline

PRODUCT_GMS_CLIENTID_BASE := android-google
TARGET_VENDOR := google
TARGET_VENDOR_PRODUCT_NAME := blueline
PRODUCT_BUILD_PROP_OVERRIDES += PRIVATE_BUILD_DESC="blueline-user 10 QP1A.190711.020 5800535 release-keys"

# Set BUILD_FINGERPRINT variable to be picked up by both system and vendor build.prop
BUILD_FINGERPRINT := google/blueline/blueline:10/QP1A.190711.020/5800535:user/release-keys
