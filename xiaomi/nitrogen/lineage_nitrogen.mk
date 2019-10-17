# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Lineage stuff
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from nitrogen device
$(call inherit-product, $(LOCAL_PATH)/device.mk)

PRODUCT_BRAND := xiaomi
PRODUCT_DEVICE := nitrogen
PRODUCT_MANUFACTURER := xiaomi
PRODUCT_NAME := lineage_nitrogen
PRODUCT_MODEL := MI MAX 3

PRODUCT_GMS_CLIENTID_BASE := android-xiaomi
TARGET_VENDOR := xiaomi
TARGET_VENDOR_PRODUCT_NAME := nitrogen
PRODUCT_BUILD_PROP_OVERRIDES += PRIVATE_BUILD_DESC="nitrogen-user 9 PKQ1.181007.001 V11.0.2.0.PEDCNXM release-keys"

# Set BUILD_FINGERPRINT variable to be picked up by both system and vendor build.prop
BUILD_FINGERPRINT := Xiaomi/nitrogen/nitrogen:9/PKQ1.181007.001/V11.0.2.0.PEDCNXM:user/release-keys
