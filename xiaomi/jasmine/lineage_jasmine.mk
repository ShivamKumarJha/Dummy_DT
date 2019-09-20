# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Lineage stuff
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from jasmine device
$(call inherit-product, $(LOCAL_PATH)/device.mk)

PRODUCT_BRAND := xiaomi
PRODUCT_DEVICE := jasmine
PRODUCT_MANUFACTURER := xiaomi
PRODUCT_NAME := lineage_jasmine
PRODUCT_MODEL := Mi A2

PRODUCT_GMS_CLIENTID_BASE := android-xiaomi
TARGET_VENDOR := xiaomi
TARGET_VENDOR_PRODUCT_NAME := jasmine
PRODUCT_BUILD_PROP_OVERRIDES += PRIVATE_BUILD_DESC="jasmine-user 9 PKQ1.180904.001 V10.0.13.0.PDIMIXM release-keys"

# Set BUILD_FINGERPRINT variable to be picked up by both system and vendor build.prop
BUILD_FINGERPRINT := xiaomi/jasmine/jasmine_sprout:9/PKQ1.180904.001/V10.0.13.0.PDIMIXM:user/release-keys
