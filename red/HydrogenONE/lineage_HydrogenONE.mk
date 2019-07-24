# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/product_launched_with_o_mr1.mk)

# Inherit some common Lineage stuff
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from HydrogenONE device
$(call inherit-product, $(LOCAL_PATH)/device.mk)

PRODUCT_BRAND := red
PRODUCT_DEVICE := HydrogenONE
PRODUCT_MANUFACTURER := red
PRODUCT_NAME := lineage_HydrogenONE
PRODUCT_MODEL := H1A1000

PRODUCT_GMS_CLIENTID_BASE := android-red
TARGET_VENDOR := red
TARGET_VENDOR_PRODUCT_NAME := HydrogenONE
PRODUCT_BUILD_PROP_OVERRIDES += PRIVATE_BUILD_DESC="hamberger_verizon-user 8.1.0 H1A1000.010ho.01.01.01r.109 109 release-keys"

# Set BUILD_FINGERPRINT variable to be picked up by both system and vendor build.prop
BUILD_FINGERPRINT := RED/HydrogenONE/HydrogenONE:8.1.0/H1A1000.010ho.01.01.01r.109/109:user/release-keys
