# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Lineage stuff
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from OnePlus7ProNR device
$(call inherit-product, $(LOCAL_PATH)/device.mk)

PRODUCT_BRAND := oneplus
PRODUCT_DEVICE := OnePlus7ProNR
PRODUCT_MANUFACTURER := oneplus
PRODUCT_NAME := lineage_OnePlus7ProNR
PRODUCT_MODEL := OnePlus 7 Pro 5G

PRODUCT_GMS_CLIENTID_BASE := android-oneplus
TARGET_VENDOR := oneplus
TARGET_VENDOR_PRODUCT_NAME := OnePlus7ProNR
PRODUCT_BUILD_PROP_OVERRIDES += PRIVATE_BUILD_DESC="OnePlus7ProNR-user 9 PKQ1.190223.001 1909251702 release-keys"

# Set BUILD_FINGERPRINT variable to be picked up by both system and vendor build.prop
BUILD_FINGERPRINT := OnePlus/OnePlus7ProNR_EEA/OnePlus7ProNR:9/PKQ1.190223.001/1909251702:user/release-keys
