# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Lineage stuff
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from pine device
$(call inherit-product, $(LOCAL_PATH)/device.mk)

PRODUCT_BRAND := xiaomi
PRODUCT_DEVICE := pine
PRODUCT_MANUFACTURER := xiaomi
PRODUCT_NAME := lineage_pine
PRODUCT_MODEL := Redmi 7A

PRODUCT_GMS_CLIENTID_BASE := android-xiaomi
TARGET_VENDOR := xiaomi
TARGET_VENDOR_PRODUCT_NAME := pine
PRODUCT_BUILD_PROP_OVERRIDES += PRIVATE_BUILD_DESC="pine-user 9 PKQ1.190319.001 V10.2.10.0.PCMCNXM release-keys"

# Set BUILD_FINGERPRINT variable to be picked up by both system and vendor build.prop
BUILD_FINGERPRINT := Xiaomi/pine/pine:9/PKQ1.190319.001/V10.2.10.0.PCMCNXM:user/release-keys
