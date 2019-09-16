# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Lineage stuff
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from PD1730E device
$(call inherit-product, $(LOCAL_PATH)/device.mk)

PRODUCT_BRAND := vivo
PRODUCT_DEVICE := PD1730E
PRODUCT_MANUFACTURER := vivo
PRODUCT_NAME := lineage_PD1730E
PRODUCT_MODEL := vivo PD1730E

PRODUCT_GMS_CLIENTID_BASE := android-vivo
TARGET_VENDOR := vivo
TARGET_VENDOR_PRODUCT_NAME := PD1730E
PRODUCT_BUILD_PROP_OVERRIDES += PRIVATE_BUILD_DESC="msm8953_64-user 8.1.0 OPM1.171019.011 eng.compil.20190624.200032 release-keys"

# Set BUILD_FINGERPRINT variable to be picked up by both system and vendor build.prop
BUILD_FINGERPRINT := vivo/PD1730E/PD1730E:8.1.0/OPM1.171019.011/compil06242000:user/release-keys
