# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/product_launched_with_p.mk)

# Inherit some common Lineage stuff
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from PD1832 device
$(call inherit-product, $(LOCAL_PATH)/device.mk)

PRODUCT_BRAND := vivo
PRODUCT_DEVICE := PD1832
PRODUCT_MANUFACTURER := vivo
PRODUCT_NAME := lineage_PD1832
PRODUCT_MODEL := vivo

PRODUCT_GMS_CLIENTID_BASE := android-vivo
TARGET_VENDOR := vivo
TARGET_VENDOR_PRODUCT_NAME := PD1832
PRODUCT_BUILD_PROP_OVERRIDES += PRIVATE_BUILD_DESC="sm6150-user 9 PKQ1.181203.001 compiler06062011 release-keys"

# Set BUILD_FINGERPRINT variable to be picked up by both system and vendor build.prop
BUILD_FINGERPRINT := vivo/PD1832/PD1832:9/PKQ1.181203.001/compiler06061955:user/release-keys
