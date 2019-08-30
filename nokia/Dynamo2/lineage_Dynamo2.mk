# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Lineage stuff
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from Dynamo2 device
$(call inherit-product, $(LOCAL_PATH)/device.mk)

PRODUCT_BRAND := nokia
PRODUCT_DEVICE := Dynamo2
PRODUCT_MANUFACTURER := nokia
PRODUCT_NAME := lineage_Dynamo2
PRODUCT_MODEL := E2M

PRODUCT_GMS_CLIENTID_BASE := android-nokia
TARGET_VENDOR := nokia
TARGET_VENDOR_PRODUCT_NAME := Dynamo2
PRODUCT_BUILD_PROP_OVERRIDES += PRIVATE_BUILD_DESC="Dynamo2_00WW-user 9 PKQ1.181105.001 00WW_1_13F release-keys"

# Set BUILD_FINGERPRINT variable to be picked up by both system and vendor build.prop
BUILD_FINGERPRINT := Nokia/Dynamo2_00WW/E2M:9/PKQ1.181105.001/00WW_1_13F:user/release-keys
