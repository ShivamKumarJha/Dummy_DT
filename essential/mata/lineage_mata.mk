# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Lineage stuff
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from mata device
$(call inherit-product, $(LOCAL_PATH)/device.mk)

PRODUCT_BRAND := essential
PRODUCT_DEVICE := mata
PRODUCT_MANUFACTURER := essential
PRODUCT_NAME := lineage_mata
PRODUCT_MODEL := PH-1

PRODUCT_GMS_CLIENTID_BASE := android-essential
TARGET_VENDOR := essential
TARGET_VENDOR_PRODUCT_NAME := mata
PRODUCT_BUILD_PROP_OVERRIDES += PRIVATE_BUILD_DESC="mata-user 10 QP1A.190711.052 351 release-keys"

# Set BUILD_FINGERPRINT variable to be picked up by both system and vendor build.prop
BUILD_FINGERPRINT := essential/mata/mata:10/QP1A.190711.052/351:user/test-keys
