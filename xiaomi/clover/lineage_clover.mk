# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Lineage stuff
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from clover device
$(call inherit-product, $(LOCAL_PATH)/device.mk)

PRODUCT_BRAND := xiaomi
PRODUCT_DEVICE := clover
PRODUCT_MANUFACTURER := xiaomi
PRODUCT_NAME := lineage_clover
PRODUCT_MODEL := MI PAD 4

PRODUCT_GMS_CLIENTID_BASE := android-xiaomi
TARGET_VENDOR := xiaomi
TARGET_VENDOR_PRODUCT_NAME := clover
PRODUCT_BUILD_PROP_OVERRIDES += PRIVATE_BUILD_DESC="clover-user 8.1.0 OPM1.171019.019 V10.3.2.0.ODJCNXM release-keys"

# Set BUILD_FINGERPRINT variable to be picked up by both system and vendor build.prop
BUILD_FINGERPRINT := Xiaomi/clover/clover:8.1.0/OPM1.171019.019/V10.3.2.0.ODJCNXM:user/release-keys
