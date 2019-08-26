# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Lineage stuff
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from andromeda device
$(call inherit-product, $(LOCAL_PATH)/device.mk)

PRODUCT_BRAND := xiaomi
PRODUCT_DEVICE := andromeda
PRODUCT_MANUFACTURER := xiaomi
PRODUCT_NAME := lineage_andromeda
PRODUCT_MODEL := Mi MIX 3 5G

PRODUCT_GMS_CLIENTID_BASE := android-xiaomi
TARGET_VENDOR := xiaomi
TARGET_VENDOR_PRODUCT_NAME := andromeda
PRODUCT_BUILD_PROP_OVERRIDES += PRIVATE_BUILD_DESC="andromeda-user 9 PKQ1.190321.001 V10.3.19.0.PEMMIXM release-keys"

# Set BUILD_FINGERPRINT variable to be picked up by both system and vendor build.prop
BUILD_FINGERPRINT := Xiaomi/andromeda/andromeda:9/PKQ1.190321.001/V10.3.19.0.PEMMIXM:user/release-keys
