# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Lineage stuff
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from OnePlus6 device
$(call inherit-product, $(LOCAL_PATH)/device.mk)

PRODUCT_BRAND := oneplus
PRODUCT_DEVICE := OnePlus6
PRODUCT_MANUFACTURER := oneplus
PRODUCT_NAME := lineage_OnePlus6
PRODUCT_MODEL := OnePlus 6

PRODUCT_GMS_CLIENTID_BASE := android-oneplus
TARGET_VENDOR := oneplus
TARGET_VENDOR_PRODUCT_NAME := OnePlus6
PRODUCT_BUILD_PROP_OVERRIDES += PRIVATE_BUILD_DESC="OnePlus6-user 10 QKQ1.190716.003 1910050400 release-keys"

# Set BUILD_FINGERPRINT variable to be picked up by both system and vendor build.prop
BUILD_FINGERPRINT := OnePlus/OnePlus6/OnePlus6:10/QKQ1.190716.003/1910050400:user/release-keys
