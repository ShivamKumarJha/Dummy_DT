# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Lineage stuff
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from Phoenix device
$(call inherit-product, $(LOCAL_PATH)/device.mk)

PRODUCT_BRAND := nokia
PRODUCT_DEVICE := Phoenix
PRODUCT_MANUFACTURER := nokia
PRODUCT_NAME := lineage_Phoenix
PRODUCT_MODEL := Nokia 8.1

PRODUCT_GMS_CLIENTID_BASE := android-nokia
TARGET_VENDOR := nokia
TARGET_VENDOR_PRODUCT_NAME := Phoenix
PRODUCT_BUILD_PROP_OVERRIDES += PRIVATE_BUILD_DESC="PNX_00WW_FIH-user 10 QKQ1.190725.002 00WW_4_15B release-keys"

# Set BUILD_FINGERPRINT variable to be picked up by both system and vendor build.prop
BUILD_FINGERPRINT := Nokia/Phoenix_00WW/PNX_sprout:10/QKQ1.190725.002/00WW_4_15B:user/release-keys
