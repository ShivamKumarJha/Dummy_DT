# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/product_launched_with_p.mk)

# Inherit some common Lineage stuff
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from lavender device
$(call inherit-product, $(LOCAL_PATH)/device.mk)

PRODUCT_BRAND := xiaomi
PRODUCT_DEVICE := lavender
PRODUCT_MANUFACTURER := xiaomi
PRODUCT_NAME := lineage_lavender
PRODUCT_MODEL := Redmi
PRODUCT_GMS_CLIENTID_BASE := android-xiaomi
TARGET_VENDOR := xiaomi
TARGET_VENDOR_PRODUCT_NAME := lavenderPRODUCT_BUILD_PROP_OVERRIDES += PRIVATE_BUILD_DESC="lavender-user 9 PKQ1.180904.001 V10.3.1.0.PFGCNXM release-keys"


# Set BUILD_FINGERPRINT variable to be picked up by both system and vendor build.propBUILD_FINGERPRINT := lavender-user 9 PKQ1.180904.001 V10.3.1.0.PFGCNXM release-keys
