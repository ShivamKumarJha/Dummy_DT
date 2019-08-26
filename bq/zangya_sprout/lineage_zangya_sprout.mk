# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Lineage stuff
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from zangya_sprout device
$(call inherit-product, $(LOCAL_PATH)/device.mk)

PRODUCT_BRAND := bq
PRODUCT_DEVICE := zangya_sprout
PRODUCT_MANUFACTURER := bq
PRODUCT_NAME := lineage_zangya_sprout
PRODUCT_MODEL := Aquaris X2

PRODUCT_GMS_CLIENTID_BASE := android-bq
TARGET_VENDOR := bq
TARGET_VENDOR_PRODUCT_NAME := zangya_sprout
PRODUCT_BUILD_PROP_OVERRIDES += PRIVATE_BUILD_DESC="zangya_bq-user 9 PKQ1.190118.001 919 release-keys"

# Set BUILD_FINGERPRINT variable to be picked up by both system and vendor build.prop
BUILD_FINGERPRINT := bq/zangya_bq/zangya_sprout:9/PKQ1.190118.001/919:user/release-keys
