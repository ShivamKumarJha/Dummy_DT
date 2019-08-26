# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Lineage stuff
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from teak device
$(call inherit-product, $(LOCAL_PATH)/device.mk)

PRODUCT_BRAND := alps
PRODUCT_DEVICE := teak
PRODUCT_MANUFACTURER := alps
PRODUCT_NAME := lineage_teak
PRODUCT_MODEL := Xperia XA1 Plus

PRODUCT_GMS_CLIENTID_BASE := android-alps
TARGET_VENDOR := alps
TARGET_VENDOR_PRODUCT_NAME := teak
PRODUCT_BUILD_PROP_OVERRIDES += PRIVATE_BUILD_DESC="full_teak-user 8.0.0 O00623 1564589454 test-keys"

# Set BUILD_FINGERPRINT variable to be picked up by both system and vendor build.prop
BUILD_FINGERPRINT := alps/full_teak/teak:8.0.0/O00623/1564589454:user/test-keys
