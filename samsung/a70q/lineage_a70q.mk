# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Lineage stuff
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from a70q device
$(call inherit-product, $(LOCAL_PATH)/device.mk)

PRODUCT_BRAND := samsung
PRODUCT_DEVICE := a70q
PRODUCT_MANUFACTURER := samsung
PRODUCT_NAME := lineage_a70q
PRODUCT_MODEL := SM-A705FN

PRODUCT_GMS_CLIENTID_BASE := android-samsung
TARGET_VENDOR := samsung
TARGET_VENDOR_PRODUCT_NAME := a70q
PRODUCT_BUILD_PROP_OVERRIDES += PRIVATE_BUILD_DESC="a70qxx-user 9 PPR1.180610.011 A705FNXXU3ASG6 release-keys"

# Set BUILD_FINGERPRINT variable to be picked up by both system and vendor build.prop
BUILD_FINGERPRINT := samsung/a70qxx/a70q:9/PPR1.180610.011/A705FNXXU3ASG6:user/release-keys
