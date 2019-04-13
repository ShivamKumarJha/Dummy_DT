# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/product_launched_with_p.mk)

# Inherit some common Lineage stuff
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from polaris device
$(call inherit-product, $(LOCAL_PATH)/device.mk)

PRODUCT_BRAND := xiaomi
PRODUCT_DEVICE := polaris
PRODUCT_MANUFACTURER := xiaomi
PRODUCT_NAME := lineage_polaris
PRODUCT_MODEL := MIX 2S

PRODUCT_GMS_CLIENTID_BASE := android-xiaomi
TARGET_VENDOR := xiaomi
TARGET_VENDOR_PRODUCT_NAME := polaris
PRODUCT_BUILD_PROP_OVERRIDES += PRIVATE_BUILD_DESC="polaris-user 9 PKQ1.180729.001 V10.3.1.0.PDGCNXM release-keys"

# Set BUILD_FINGERPRINT variable to be picked up by both system and vendor build.prop
BUILD_FINGERPRINT := Xiaomi/polaris/polaris:9/PKQ1.180729.001/V10.3.1.0.PDGCNXM:user/release-keys
