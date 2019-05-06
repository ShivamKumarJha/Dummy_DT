# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/product_launched_with_o_mr1.mk)

# Inherit some common Lineage stuff
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from PD1816 device
$(call inherit-product, $(LOCAL_PATH)/device.mk)

PRODUCT_BRAND := vivo
PRODUCT_DEVICE := PD1816
PRODUCT_MANUFACTURER := vivo
PRODUCT_NAME := lineage_PD1816
PRODUCT_MODEL := vivo PD1816

PRODUCT_GMS_CLIENTID_BASE := android-vivo
TARGET_VENDOR := vivo
TARGET_VENDOR_PRODUCT_NAME := PD1816
PRODUCT_BUILD_PROP_OVERRIDES += PRIVATE_BUILD_DESC="sdm660_64-user 8.1.0 OPM1.171019.011 eng.compil.20190118.202309 release-keys"

# Set BUILD_FINGERPRINT variable to be picked up by both system and vendor build.prop
BUILD_FINGERPRINT := vivo/PD1816/PD1816:8.1.0/OPM1.171019.011/compil01182023:user/release-keys
