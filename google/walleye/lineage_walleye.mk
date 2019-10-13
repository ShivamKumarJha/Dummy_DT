# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Lineage stuff
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from walleye device
$(call inherit-product, $(LOCAL_PATH)/device.mk)

PRODUCT_BRAND := google
PRODUCT_DEVICE := walleye
PRODUCT_MANUFACTURER := google
PRODUCT_NAME := lineage_walleye
PRODUCT_MODEL := Pixel 2

PRODUCT_GMS_CLIENTID_BASE := android-google
TARGET_VENDOR := google
TARGET_VENDOR_PRODUCT_NAME := walleye
PRODUCT_BUILD_PROP_OVERRIDES += PRIVATE_BUILD_DESC="walleye-user 10 QP1A.191005.007.A1 5908163 release-keys"

# Set BUILD_FINGERPRINT variable to be picked up by both system and vendor build.prop
BUILD_FINGERPRINT := google/walleye/walleye:10/QP1A.191005.007.A1/5908163:user/release-keys
