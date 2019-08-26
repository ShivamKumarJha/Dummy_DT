# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Lineage stuff
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from beryllium device
$(call inherit-product, $(LOCAL_PATH)/device.mk)

PRODUCT_BRAND := xiaomi
PRODUCT_DEVICE := beryllium
PRODUCT_MANUFACTURER := xiaomi
PRODUCT_NAME := lineage_beryllium
PRODUCT_MODEL := POCO F1

PRODUCT_GMS_CLIENTID_BASE := android-xiaomi
TARGET_VENDOR := xiaomi
TARGET_VENDOR_PRODUCT_NAME := beryllium
PRODUCT_BUILD_PROP_OVERRIDES += PRIVATE_BUILD_DESC="beryllium-user 9 PKQ1.180729.001 V10.3.6.0.PEJMIXM release-keys"

# Set BUILD_FINGERPRINT variable to be picked up by both system and vendor build.prop
BUILD_FINGERPRINT := Xiaomi/beryllium/beryllium:9/PKQ1.180729.001/V10.3.6.0.PEJMIXM:user/release-keys
