# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Lineage stuff
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from natrium device
$(call inherit-product, $(LOCAL_PATH)/device.mk)

PRODUCT_BRAND := xiaomi
PRODUCT_DEVICE := natrium
PRODUCT_MANUFACTURER := xiaomi
PRODUCT_NAME := lineage_natrium
PRODUCT_MODEL := MI 5s Plus

PRODUCT_GMS_CLIENTID_BASE := android-xiaomi
TARGET_VENDOR := xiaomi
TARGET_VENDOR_PRODUCT_NAME := natrium
PRODUCT_BUILD_PROP_OVERRIDES += PRIVATE_BUILD_DESC="natrium-user 8.0.0 OPR1.170623.032 V10.2.4.0.OBGMIXM release-keys"

# Set BUILD_FINGERPRINT variable to be picked up by both system and vendor build.prop
BUILD_FINGERPRINT := Xiaomi/natrium/natrium:8.0.0/OPR1.170623.032/V10.2.4.0.OBGMIXM:user/release-keys
