# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/product_launched_with_p.mk)

# Inherit some common Lineage stuff
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from bonito device
$(call inherit-product, $(LOCAL_PATH)/device.mk)

PRODUCT_BRAND := google
PRODUCT_DEVICE := bonito
PRODUCT_MANUFACTURER := google
PRODUCT_NAME := lineage_bonito
PRODUCT_MODEL := Pixel 3a XL

PRODUCT_GMS_CLIENTID_BASE := android-google
TARGET_VENDOR := google
TARGET_VENDOR_PRODUCT_NAME := bonito
PRODUCT_BUILD_PROP_OVERRIDES += PRIVATE_BUILD_DESC="bonito-user 9 PD2A.190115.032 5340326 release-keys"

# Set BUILD_FINGERPRINT variable to be picked up by both system and vendor build.prop
BUILD_FINGERPRINT := google/bonito/bonito:9/PD2A.190115.032/5340326:user/release-keys
