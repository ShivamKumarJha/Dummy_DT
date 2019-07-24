# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/product_launched_with_o_mr1.mk)

# Inherit some common Lineage stuff
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from X00PD device
$(call inherit-product, $(LOCAL_PATH)/device.mk)

PRODUCT_BRAND := asus
PRODUCT_DEVICE := X00PD
PRODUCT_MANUFACTURER := asus
PRODUCT_NAME := lineage_X00PD
PRODUCT_MODEL := X00PD

PRODUCT_GMS_CLIENTID_BASE := android-asus
TARGET_VENDOR := asus
TARGET_VENDOR_PRODUCT_NAME := X00PD
PRODUCT_BUILD_PROP_OVERRIDES += PRIVATE_BUILD_DESC="E300L_WW-user 8.0.0 OPR1.170623.032 eng.root.20190521.160404 release-keys"

# Set BUILD_FINGERPRINT variable to be picked up by both system and vendor build.prop
BUILD_FINGERPRINT := E300L_WW-user 8.0.0 OPR1.170623.032 eng.root.20190521.160404 release-keys
