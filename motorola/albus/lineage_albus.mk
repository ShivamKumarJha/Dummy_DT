# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Lineage stuff
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from albus device
$(call inherit-product, $(LOCAL_PATH)/device.mk)

PRODUCT_BRAND := motorola
PRODUCT_DEVICE := albus
PRODUCT_MANUFACTURER := motorola
PRODUCT_NAME := lineage_albus
PRODUCT_MODEL := Moto Z2 Play

PRODUCT_GMS_CLIENTID_BASE := android-motorola
TARGET_VENDOR := motorola
TARGET_VENDOR_PRODUCT_NAME := albus
PRODUCT_BUILD_PROP_OVERRIDES += PRIVATE_BUILD_DESC=" 9 PPS29.133-30 ab8b4 release-keys"

# Set BUILD_FINGERPRINT variable to be picked up by both system and vendor build.prop
BUILD_FINGERPRINT := 9/PPS29.133-30/ab8b4:user/release-keys
