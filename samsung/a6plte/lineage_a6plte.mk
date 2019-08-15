# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Lineage stuff
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from a6plte device
$(call inherit-product, $(LOCAL_PATH)/device.mk)

PRODUCT_BRAND := samsung
PRODUCT_DEVICE := a6plte
PRODUCT_MANUFACTURER := samsung
PRODUCT_NAME := lineage_a6plte
PRODUCT_MODEL := SM-A605FN

PRODUCT_GMS_CLIENTID_BASE := android-samsung
TARGET_VENDOR := samsung
TARGET_VENDOR_PRODUCT_NAME := a6plte
PRODUCT_BUILD_PROP_OVERRIDES += PRIVATE_BUILD_DESC="a6pltexx-user 9 PPR1.180610.011 A605FNXXU3BSC6 release-keys"

# Set BUILD_FINGERPRINT variable to be picked up by both system and vendor build.prop
BUILD_FINGERPRINT := samsung/a6pltexx/a6plte:9/PPR1.180610.011/A605FNXXU3BSC6:user/release-keys
