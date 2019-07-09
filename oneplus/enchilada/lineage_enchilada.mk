# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/product_launched_with_p.mk)

# Inherit some common Lineage stuff
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from enchilada device
$(call inherit-product, $(LOCAL_PATH)/device.mk)

PRODUCT_BRAND := oneplus
PRODUCT_DEVICE := enchilada
PRODUCT_MANUFACTURER := oneplus
PRODUCT_NAME := lineage_enchilada
PRODUCT_MODEL := OnePlus6

PRODUCT_GMS_CLIENTID_BASE := android-oneplus
TARGET_VENDOR := oneplus
TARGET_VENDOR_PRODUCT_NAME := enchilada
PRODUCT_BUILD_PROP_OVERRIDES += PRIVATE_BUILD_DESC="OnePlus6-user 9 PKQ1.180716.001 1810252315 release-keys"

# Set BUILD_FINGERPRINT variable to be picked up by both system and vendor build.prop
BUILD_FINGERPRINT := OnePlus/OnePlus6/OnePlus6:9/PKQ1.180716.001/1810252315:user/release-keys
