# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Lineage stuff
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from ginkgo device
$(call inherit-product, $(LOCAL_PATH)/device.mk)

PRODUCT_BRAND := xiaomi
PRODUCT_DEVICE := ginkgo
PRODUCT_MANUFACTURER := xiaomi
PRODUCT_NAME := lineage_ginkgo
PRODUCT_MODEL := Redmi Note 8

PRODUCT_GMS_CLIENTID_BASE := android-xiaomi
TARGET_VENDOR := xiaomi
TARGET_VENDOR_PRODUCT_NAME := ginkgo
PRODUCT_BUILD_PROP_OVERRIDES += PRIVATE_BUILD_DESC="ginkgo-user 9 PKQ1.190616.001 V10.3.1.0.PCOINXM release-keys"

# Set BUILD_FINGERPRINT variable to be picked up by both system and vendor build.prop
BUILD_FINGERPRINT := xiaomi/ginkgo/ginkgo:9/PKQ1.190616.001/V10.3.1.0.PCOINXM:user/release-keys
