# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Lineage stuff
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from raphaelin device
$(call inherit-product, $(LOCAL_PATH)/device.mk)

PRODUCT_BRAND := xiaomi
PRODUCT_DEVICE := raphaelin
PRODUCT_MANUFACTURER := xiaomi
PRODUCT_NAME := lineage_raphaelin
PRODUCT_MODEL := Redmi K20 Pro

PRODUCT_GMS_CLIENTID_BASE := android-xiaomi
TARGET_VENDOR := xiaomi
TARGET_VENDOR_PRODUCT_NAME := raphaelin
PRODUCT_BUILD_PROP_OVERRIDES += PRIVATE_BUILD_DESC="raphaelin-user 10 QKQ1.190716.003 V10.4.8.0.QFKINXM release-keys"

# Set BUILD_FINGERPRINT variable to be picked up by both system and vendor build.prop
BUILD_FINGERPRINT := Xiaomi/raphaelin/raphaelin:10/QKQ1.190716.003/V10.4.8.0.QFKINXM:user/release-keys
