# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Lineage stuff
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from J8110 device
$(call inherit-product, $(LOCAL_PATH)/device.mk)

PRODUCT_BRAND := sony
PRODUCT_DEVICE := J8110
PRODUCT_MANUFACTURER := sony
PRODUCT_NAME := lineage_J8110
PRODUCT_MODEL := Xperia 1

PRODUCT_GMS_CLIENTID_BASE := android-sony
TARGET_VENDOR := sony
TARGET_VENDOR_PRODUCT_NAME := J8110
PRODUCT_BUILD_PROP_OVERRIDES += PRIVATE_BUILD_DESC="J8110-user 9 55.0.A.6.16 1274184004 release-keys"

# Set BUILD_FINGERPRINT variable to be picked up by both system and vendor build.prop
BUILD_FINGERPRINT := Sony/J8110_EEA/J8110:9/55.0.A.6.16/1274184004:user/release-keys
