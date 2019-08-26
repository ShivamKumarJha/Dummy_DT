# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Lineage stuff
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from zap device
$(call inherit-product, $(LOCAL_PATH)/device.mk)

PRODUCT_BRAND := lenovo
PRODUCT_DEVICE := zap
PRODUCT_MANUFACTURER := lenovo
PRODUCT_NAME := lineage_zap
PRODUCT_MODEL := Lenovo Z5 Pro

PRODUCT_GMS_CLIENTID_BASE := android-lenovo
TARGET_VENDOR := lenovo
TARGET_VENDOR_PRODUCT_NAME := zap
PRODUCT_BUILD_PROP_OVERRIDES += PRIVATE_BUILD_DESC="zap-user 9 PKQ1.190127.001 11.1.093_190725 release-keys"

# Set BUILD_FINGERPRINT variable to be picked up by both system and vendor build.prop
BUILD_FINGERPRINT := Lenovo/zap/zap:9/PKQ1.190127.001/11.1.093_190725:user/release-keys
