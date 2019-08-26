# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Lineage stuff
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from yamcha device
$(call inherit-product, $(LOCAL_PATH)/device.mk)

PRODUCT_BRAND := bq
PRODUCT_DEVICE := yamcha
PRODUCT_MANUFACTURER := bq
PRODUCT_NAME := lineage_yamcha
PRODUCT_MODEL := Aquaris U2

PRODUCT_GMS_CLIENTID_BASE := android-bq
TARGET_VENDOR := bq
TARGET_VENDOR_PRODUCT_NAME := yamcha
PRODUCT_BUILD_PROP_OVERRIDES += PRIVATE_BUILD_DESC="yamcha_bq-user 8.1.0 OPM1.171019.026 1692 release-keys"

# Set BUILD_FINGERPRINT variable to be picked up by both system and vendor build.prop
BUILD_FINGERPRINT := bq/yamcha/yamcha:8.1.0/OPM1.171019.026/1692:user/release-keys
