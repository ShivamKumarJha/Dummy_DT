# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Lineage stuff
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from heart device
$(call inherit-product, $(LOCAL_PATH)/device.mk)

PRODUCT_BRAND := lenovo
PRODUCT_DEVICE := heart
PRODUCT_MANUFACTURER := lenovo
PRODUCT_NAME := lineage_heart
PRODUCT_MODEL := Lenovo Z5 Pro GT

PRODUCT_GMS_CLIENTID_BASE := android-lenovo
TARGET_VENDOR := lenovo
TARGET_VENDOR_PRODUCT_NAME := heart
PRODUCT_BUILD_PROP_OVERRIDES += PRIVATE_BUILD_DESC="heart-user 9 PKQ1.190110.001 10.5.304_190710 release-keys"

# Set BUILD_FINGERPRINT variable to be picked up by both system and vendor build.prop
BUILD_FINGERPRINT := Lenovo/heart/heart:9/PKQ1.190110.001/10.5.304_190710:user/release-keys
