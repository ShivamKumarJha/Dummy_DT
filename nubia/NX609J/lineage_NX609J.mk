# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Lineage stuff
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from NX609J device
$(call inherit-product, $(LOCAL_PATH)/device.mk)

PRODUCT_BRAND := nubia
PRODUCT_DEVICE := NX609J
PRODUCT_MANUFACTURER := nubia
PRODUCT_NAME := lineage_NX609J
PRODUCT_MODEL := NX609J

PRODUCT_GMS_CLIENTID_BASE := android-nubia
TARGET_VENDOR := nubia
TARGET_VENDOR_PRODUCT_NAME := NX609J
PRODUCT_BUILD_PROP_OVERRIDES += PRIVATE_BUILD_DESC="NX609J-user 9 PKQ1.181021.001 eng.nubia.20190521.182255 release-keys"

# Set BUILD_FINGERPRINT variable to be picked up by both system and vendor build.prop
BUILD_FINGERPRINT := nubia/NX609J/NX609J:9/PKQ1.181021.001/eng.nubia.20190521.182255:user/release-keys
