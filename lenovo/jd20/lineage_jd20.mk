# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Lineage stuff
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from jd20 device
$(call inherit-product, $(LOCAL_PATH)/device.mk)

PRODUCT_BRAND := lenovo
PRODUCT_DEVICE := jd20
PRODUCT_MANUFACTURER := lenovo
PRODUCT_NAME := lineage_jd20
PRODUCT_MODEL := Lenovo Z6

PRODUCT_GMS_CLIENTID_BASE := android-lenovo
TARGET_VENDOR := lenovo
TARGET_VENDOR_PRODUCT_NAME := jd20
PRODUCT_BUILD_PROP_OVERRIDES += PRIVATE_BUILD_DESC="jd20-user 9 PKQ1.190319.001 11.1.087_190607 release-keys"

# Set BUILD_FINGERPRINT variable to be picked up by both system and vendor build.prop
BUILD_FINGERPRINT := Lenovo/jd20/jd20:9/PKQ1.190319.001/11.1.087_190607:user/release-keys
