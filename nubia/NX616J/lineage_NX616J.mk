# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/product_launched_with_o_mr1.mk)

# Inherit some common Lineage stuff
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from NX616J device
$(call inherit-product, $(LOCAL_PATH)/device.mk)

PRODUCT_BRAND := nubia
PRODUCT_DEVICE := NX616J
PRODUCT_MANUFACTURER := nubia
PRODUCT_NAME := lineage_NX616J
PRODUCT_MODEL := NX616J

PRODUCT_GMS_CLIENTID_BASE := android-nubia
TARGET_VENDOR := nubia
TARGET_VENDOR_PRODUCT_NAME := NX616J
PRODUCT_BUILD_PROP_OVERRIDES += PRIVATE_BUILD_DESC="NX616J-user 8.1.0 OPM1.171019.026 eng.nubia.20190112.004817 release-keys"

# Set BUILD_FINGERPRINT variable to be picked up by both system and vendor build.prop
BUILD_FINGERPRINT := nubia/NX616J/NX616J:8.1.0/OPM1.171019.026/nubia01120048:user/release-keys
