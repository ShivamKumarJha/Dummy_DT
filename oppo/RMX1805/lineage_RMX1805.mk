# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Lineage stuff
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from RMX1805 device
$(call inherit-product, $(LOCAL_PATH)/device.mk)

PRODUCT_BRAND := oppo
PRODUCT_DEVICE := RMX1805
PRODUCT_MANUFACTURER := oppo
PRODUCT_NAME := lineage_RMX1805
PRODUCT_MODEL := realme C1

PRODUCT_GMS_CLIENTID_BASE := android-oppo
TARGET_VENDOR := oppo
TARGET_VENDOR_PRODUCT_NAME := RMX1805
PRODUCT_BUILD_PROP_OVERRIDES += PRIVATE_BUILD_DESC="S88051AA1-user 9 PKQ1.190319.001 eng.root.20190924.190907 release-keys"

# Set BUILD_FINGERPRINT variable to be picked up by both system and vendor build.prop
BUILD_FINGERPRINT := S88051AA1-user-9-PKQ1.190319.001-eng.root.20190924.190907-release-keys
