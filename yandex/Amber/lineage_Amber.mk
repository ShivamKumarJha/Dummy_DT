# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Lineage stuff
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from Amber device
$(call inherit-product, $(LOCAL_PATH)/device.mk)

PRODUCT_BRAND := yandex
PRODUCT_DEVICE := Amber
PRODUCT_MANUFACTURER := yandex
PRODUCT_NAME := lineage_Amber
PRODUCT_MODEL := YNDX-000SB

PRODUCT_GMS_CLIENTID_BASE := android-yandex
TARGET_VENDOR := yandex
TARGET_VENDOR_PRODUCT_NAME := Amber
PRODUCT_BUILD_PROP_OVERRIDES += PRIVATE_BUILD_DESC="yphone-user 8.1.0 8710.1.A.0063.20190415 04150906 release-keys"

# Set BUILD_FINGERPRINT variable to be picked up by both system and vendor build.prop
BUILD_FINGERPRINT := Yandex/Amber/Amber:8.1.0/8710.1.A.0063.20190415/04150906:user/release-keys
