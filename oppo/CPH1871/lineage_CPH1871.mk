# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Lineage stuff
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from CPH1871 device
$(call inherit-product, $(LOCAL_PATH)/device.mk)

PRODUCT_BRAND := oppo
PRODUCT_DEVICE := CPH1871
PRODUCT_MANUFACTURER := oppo
PRODUCT_NAME := lineage_CPH1871
PRODUCT_MODEL := OPPO Find X

PRODUCT_GMS_CLIENTID_BASE := android-oppo
TARGET_VENDOR := oppo
TARGET_VENDOR_PRODUCT_NAME := CPH1871
PRODUCT_BUILD_PROP_OVERRIDES += PRIVATE_BUILD_DESC="sdm845-user 8.1.0 OPM1.171019.026 eng.root.20190928.010333 release-keys"

# Set BUILD_FINGERPRINT variable to be picked up by both system and vendor build.prop
BUILD_FINGERPRINT := sdm845-user-8.1.0-OPM1.171019.026-eng.root.20190928.010333-release-keys
