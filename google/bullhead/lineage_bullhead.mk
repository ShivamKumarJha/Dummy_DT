# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Lineage stuff
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from bullhead device
$(call inherit-product, $(LOCAL_PATH)/device.mk)

PRODUCT_BRAND := google
PRODUCT_DEVICE := bullhead
PRODUCT_MANUFACTURER := google
PRODUCT_NAME := lineage_bullhead
PRODUCT_MODEL := Nexus 5X

PRODUCT_GMS_CLIENTID_BASE := android-google
TARGET_VENDOR := google
TARGET_VENDOR_PRODUCT_NAME := bullhead
PRODUCT_BUILD_PROP_OVERRIDES += PRIVATE_BUILD_DESC="bullhead-user 8.1.0 OPM7.181205.001 5080180 release-keys"

# Set BUILD_FINGERPRINT variable to be picked up by both system and vendor build.prop
BUILD_FINGERPRINT := google/bullhead/bullhead:8.1.0/OPM7.181205.001/5080180:user/release-keys
