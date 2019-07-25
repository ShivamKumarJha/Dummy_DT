# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/product_launched_with_p.mk)

# Inherit some common Lineage stuff
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from akatsuki device
$(call inherit-product, $(LOCAL_PATH)/device.mk)

PRODUCT_BRAND := sony
PRODUCT_DEVICE := akatsuki
PRODUCT_MANUFACTURER := sony
PRODUCT_NAME := lineage_akatsuki
PRODUCT_MODEL := H8416

PRODUCT_GMS_CLIENTID_BASE := android-sony
TARGET_VENDOR := sony
TARGET_VENDOR_PRODUCT_NAME := akatsuki
PRODUCT_BUILD_PROP_OVERRIDES += PRIVATE_BUILD_DESC="akatsuki-user 9 TAMA2-2.0.1-190614-0634 1 dev-keys"

# Set BUILD_FINGERPRINT variable to be picked up by both system and vendor build.prop
BUILD_FINGERPRINT := Sony/akatsuki/akatsuki:9/TAMA2-2.0.1-190614-0634/1:user/dev-keys
