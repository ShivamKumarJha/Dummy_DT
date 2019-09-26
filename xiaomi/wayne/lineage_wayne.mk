# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Lineage stuff
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from wayne device
$(call inherit-product, $(LOCAL_PATH)/device.mk)

PRODUCT_BRAND := xiaomi
PRODUCT_DEVICE := wayne
PRODUCT_MANUFACTURER := xiaomi
PRODUCT_NAME := lineage_wayne
PRODUCT_MODEL := MI 6X

PRODUCT_GMS_CLIENTID_BASE := android-xiaomi
TARGET_VENDOR := xiaomi
TARGET_VENDOR_PRODUCT_NAME := wayne
PRODUCT_BUILD_PROP_OVERRIDES += PRIVATE_BUILD_DESC="wayne-user 9 PKQ1.180904.001 9.9.24 release-keys"

# Set BUILD_FINGERPRINT variable to be picked up by both system and vendor build.prop
BUILD_FINGERPRINT := xiaomi/wayne/wayne:9/PKQ1.180904.001/9.9.24:user/release-keys
