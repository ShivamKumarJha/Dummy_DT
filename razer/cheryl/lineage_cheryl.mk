# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Lineage stuff
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from cheryl device
$(call inherit-product, $(LOCAL_PATH)/device.mk)

PRODUCT_BRAND := razer
PRODUCT_DEVICE := cheryl
PRODUCT_MANUFACTURER := razer
PRODUCT_NAME := lineage_cheryl
PRODUCT_MODEL := Phone

PRODUCT_GMS_CLIENTID_BASE := android-razer
TARGET_VENDOR := razer
TARGET_VENDOR_PRODUCT_NAME := cheryl
PRODUCT_BUILD_PROP_OVERRIDES += PRIVATE_BUILD_DESC="cheryl-user 9 P-MR0-RC006-RZR-N 7069 release-keys"

# Set BUILD_FINGERPRINT variable to be picked up by both system and vendor build.prop
BUILD_FINGERPRINT := razer/cheryl/cheryl:9/P-MR0-RC006-RZR-N/7069:user/release-keys
