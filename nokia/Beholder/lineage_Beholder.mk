# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Lineage stuff
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from Beholder device
$(call inherit-product, $(LOCAL_PATH)/device.mk)

PRODUCT_BRAND := nokia
PRODUCT_DEVICE := Beholder
PRODUCT_MANUFACTURER := nokia
PRODUCT_NAME := lineage_Beholder
PRODUCT_MODEL := AOP

PRODUCT_GMS_CLIENTID_BASE := android-nokia
TARGET_VENDOR := nokia
TARGET_VENDOR_PRODUCT_NAME := Beholder
PRODUCT_BUILD_PROP_OVERRIDES += PRIVATE_BUILD_DESC="Beholder_00WW-user 9 PPR1.180610.011 00WW_4_27D release-keys"

# Set BUILD_FINGERPRINT variable to be picked up by both system and vendor build.prop
BUILD_FINGERPRINT := Nokia/Beholder_00WW/fih_sdm845:9/PPR1.180610.011/00WW_4_27D:user/release-keys
