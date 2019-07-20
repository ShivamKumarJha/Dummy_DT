# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/product_launched_with_p.mk)

# Inherit some common Lineage stuff
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from X00QD device
$(call inherit-product, $(LOCAL_PATH)/device.mk)

PRODUCT_BRAND := asus
PRODUCT_DEVICE := X00QD
PRODUCT_MANUFACTURER := asus
PRODUCT_NAME := lineage_X00QD
PRODUCT_MODEL := ASUS_X00QD

PRODUCT_GMS_CLIENTID_BASE := android-asus
TARGET_VENDOR := asus
TARGET_VENDOR_PRODUCT_NAME := X00QD
PRODUCT_BUILD_PROP_OVERRIDES += PRIVATE_BUILD_DESC="WW_Phone-user 9 PPR1.180610.009 16.0615.1905.100-0 release-keys"

# Set BUILD_FINGERPRINT variable to be picked up by both system and vendor build.prop
BUILD_FINGERPRINT := asus/WW_Phone/ASUS_X00QD:9/PPR1.180610.009/16.0615.1905.100-0:user/release-keys
