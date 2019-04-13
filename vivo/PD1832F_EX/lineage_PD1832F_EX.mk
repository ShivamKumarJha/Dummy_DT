# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/product_launched_with_p.mk)

# Inherit some common Lineage stuff
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from PD1832F_EX device
$(call inherit-product, $(LOCAL_PATH)/device.mk)

PRODUCT_BRAND := vivo
PRODUCT_DEVICE := PD1832F_EX
PRODUCT_MANUFACTURER := vivo
PRODUCT_NAME := lineage_PD1832F_EX
PRODUCT_MODEL := vivo 1818

PRODUCT_GMS_CLIENTID_BASE := android-vivo
TARGET_VENDOR := vivo
TARGET_VENDOR_PRODUCT_NAME := PD1832F_EX
PRODUCT_BUILD_PROP_OVERRIDES += PRIVATE_BUILD_DESC="sm6150-user 9 PKQ1.181203.001 compiler02250201 release-keys"

# Set BUILD_FINGERPRINT variable to be picked up by both system and vendor build.prop
BUILD_FINGERPRINT := vivo/1818/1818:9/PKQ1.181203.001/compiler02250201:user/release-keys
