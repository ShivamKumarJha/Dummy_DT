# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Lineage stuff
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from U_Pro device
$(call inherit-product, $(LOCAL_PATH)/device.mk)

PRODUCT_BRAND := elephone
PRODUCT_DEVICE := U_Pro
PRODUCT_MANUFACTURER := elephone
PRODUCT_NAME := lineage_U_Pro
PRODUCT_MODEL := U_Pro

PRODUCT_GMS_CLIENTID_BASE := android-elephone
TARGET_VENDOR := elephone
TARGET_VENDOR_PRODUCT_NAME := U_Pro
PRODUCT_BUILD_PROP_OVERRIDES += PRIVATE_BUILD_DESC="sdm660_64-user 8.0.0 Elephone_U_Pro_20180918 09180928 release-keys"

# Set BUILD_FINGERPRINT variable to be picked up by both system and vendor build.prop
BUILD_FINGERPRINT := Elephone/U_Pro/U_Pro:8.0.0/Elephone_U_Pro_20180918/09180928:user/release-keys
