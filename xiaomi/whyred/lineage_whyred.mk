# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Lineage stuff
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from whyred device
$(call inherit-product, $(LOCAL_PATH)/device.mk)

PRODUCT_BRAND := xiaomi
PRODUCT_DEVICE := whyred
PRODUCT_MANUFACTURER := xiaomi
PRODUCT_NAME := lineage_whyred
PRODUCT_MODEL := Redmi Note 5

PRODUCT_GMS_CLIENTID_BASE := android-xiaomi
TARGET_VENDOR := xiaomi
TARGET_VENDOR_PRODUCT_NAME := whyred
PRODUCT_BUILD_PROP_OVERRIDES += PRIVATE_BUILD_DESC="whyred-user 9 PKQ1.180904.001 9.8.22 release-keys"

# Set BUILD_FINGERPRINT variable to be picked up by both system and vendor build.prop
BUILD_FINGERPRINT := xiaomi/whyred/whyred:9/PKQ1.180904.001/9.8.22:user/release-keys
