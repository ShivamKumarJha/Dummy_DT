# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Lineage stuff
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from dipper device
$(call inherit-product, $(LOCAL_PATH)/device.mk)

PRODUCT_BRAND := xiaomi
PRODUCT_DEVICE := dipper
PRODUCT_MANUFACTURER := xiaomi
PRODUCT_NAME := lineage_dipper
PRODUCT_MODEL := MI 8

PRODUCT_GMS_CLIENTID_BASE := android-xiaomi
TARGET_VENDOR := xiaomi
TARGET_VENDOR_PRODUCT_NAME := dipper
PRODUCT_BUILD_PROP_OVERRIDES += PRIVATE_BUILD_DESC="dipper-user 10 QKQ1.190828.002 9.10.17 release-keys"

# Set BUILD_FINGERPRINT variable to be picked up by both system and vendor build.prop
BUILD_FINGERPRINT := Xiaomi/dipper/dipper:10/QKQ1.190828.002/9.10.17:user/release-keys
