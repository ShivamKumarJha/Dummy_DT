# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Lineage stuff
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from discovery device
$(call inherit-product, $(LOCAL_PATH)/device.mk)

PRODUCT_BRAND := sony
PRODUCT_DEVICE := discovery
PRODUCT_MANUFACTURER := sony
PRODUCT_NAME := lineage_discovery
PRODUCT_MODEL := Xperia XA2 Ultra

PRODUCT_GMS_CLIENTID_BASE := android-sony
TARGET_VENDOR := sony
TARGET_VENDOR_PRODUCT_NAME := discovery
PRODUCT_BUILD_PROP_OVERRIDES += PRIVATE_BUILD_DESC="discovery-user 9 P-NILE-CAF-190723-0742 1 dev-keys"

# Set BUILD_FINGERPRINT variable to be picked up by both system and vendor build.prop
BUILD_FINGERPRINT := Sony/discovery/discovery:9/P-NILE-CAF-190723-0742/1:user/dev-keys
