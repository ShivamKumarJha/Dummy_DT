# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Lineage stuff
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from OnePlus7T device
$(call inherit-product, $(LOCAL_PATH)/device.mk)

PRODUCT_BRAND := oneplus
PRODUCT_DEVICE := OnePlus7T
PRODUCT_MANUFACTURER := oneplus
PRODUCT_NAME := lineage_OnePlus7T
PRODUCT_MODEL := OnePlus7T

PRODUCT_GMS_CLIENTID_BASE := android-oneplus
TARGET_VENDOR := oneplus
TARGET_VENDOR_PRODUCT_NAME := OnePlus7T
PRODUCT_BUILD_PROP_OVERRIDES += PRIVATE_BUILD_DESC="hotdogb-user 10 QKQ1.190716.003 1910122112 release-keys"

# Set BUILD_FINGERPRINT variable to be picked up by both system and vendor build.prop
BUILD_FINGERPRINT := OnePlus/OnePlus7T/OnePlus7T:10/QKQ1.190716.003/1910122112:user/release-keys
