# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/product_launched_with_o_mr1.mk)

# Inherit some common Lineage stuff
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from X8 device
$(call inherit-product, $(LOCAL_PATH)/device.mk)

PRODUCT_BRAND := meizu
PRODUCT_DEVICE := X8
PRODUCT_MANUFACTURER := meizu
PRODUCT_NAME := lineage_X8
PRODUCT_MODEL := meizu X8

PRODUCT_GMS_CLIENTID_BASE := android-meizu
TARGET_VENDOR := meizu
TARGET_VENDOR_PRODUCT_NAME := X8
PRODUCT_BUILD_PROP_OVERRIDES += PRIVATE_BUILD_DESC="meizu_X8-user 8.1.0 OPM1.171019.026 1546077651 release-keys"

# Set BUILD_FINGERPRINT variable to be picked up by both system and vendor build.prop
BUILD_FINGERPRINT := Meizu/meizu_X8/X8:8.1.0/OPM1.171019.026/1546077651:user/release-keys
