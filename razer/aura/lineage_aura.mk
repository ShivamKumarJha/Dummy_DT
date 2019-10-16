# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Lineage stuff
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from aura device
$(call inherit-product, $(LOCAL_PATH)/device.mk)

PRODUCT_BRAND := razer
PRODUCT_DEVICE := aura
PRODUCT_MANUFACTURER := razer
PRODUCT_NAME := lineage_aura
PRODUCT_MODEL := Phone 2

PRODUCT_GMS_CLIENTID_BASE := android-razer
TARGET_VENDOR := razer
TARGET_VENDOR_PRODUCT_NAME := aura
PRODUCT_BUILD_PROP_OVERRIDES += PRIVATE_BUILD_DESC="aura-user 9 P-MR2-RC001-RZR-190914 3123 release-keys"

# Set BUILD_FINGERPRINT variable to be picked up by both system and vendor build.prop
BUILD_FINGERPRINT := razer/cheryl2/aura:9/P-MR2-RC001-RZR-190914/3123:user/release-keys
