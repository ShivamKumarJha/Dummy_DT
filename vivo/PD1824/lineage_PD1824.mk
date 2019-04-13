# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/product_launched_with_p.mk)

# Inherit some common Lineage stuff
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from PD1824 device
$(call inherit-product, $(LOCAL_PATH)/device.mk)

PRODUCT_BRAND := vivo
PRODUCT_DEVICE := PD1824
PRODUCT_MANUFACTURER := vivo
PRODUCT_NAME := lineage_PD1824
PRODUCT_MODEL := vivo

PRODUCT_GMS_CLIENTID_BASE := android-vivo
TARGET_VENDOR := vivo
TARGET_VENDOR_PRODUCT_NAME := PD1824
PRODUCT_BUILD_PROP_OVERRIDES += PRIVATE_BUILD_DESC="msmnile-user 9 PKQ1.181216.001 compiler03081254 release-keys"

# Set BUILD_FINGERPRINT variable to be picked up by both system and vendor build.prop
BUILD_FINGERPRINT := vivo/PD1824/PD1824:9/PKQ1.181216.001/compiler03081254:user/release-keys
