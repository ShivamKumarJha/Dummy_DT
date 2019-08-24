# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Lineage stuff
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from sailfish device
$(call inherit-product, $(LOCAL_PATH)/device.mk)

PRODUCT_BRAND := google
PRODUCT_DEVICE := sailfish
PRODUCT_MANUFACTURER := google
PRODUCT_NAME := lineage_sailfish
PRODUCT_MODEL := Pixel

PRODUCT_GMS_CLIENTID_BASE := android-google
TARGET_VENDOR := google
TARGET_VENDOR_PRODUCT_NAME := sailfish
PRODUCT_BUILD_PROP_OVERRIDES += PRIVATE_BUILD_DESC="sailfish-user 9 PQ3A.190801.002 5670241 release-keys"

# Set BUILD_FINGERPRINT variable to be picked up by both system and vendor build.prop
BUILD_FINGERPRINT := google/sailfish/sailfish:9/PQ3A.190801.002/5670241:user/release-keys
