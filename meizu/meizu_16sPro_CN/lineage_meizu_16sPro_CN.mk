# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Lineage stuff
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from meizu_16sPro_CN device
$(call inherit-product, $(LOCAL_PATH)/device.mk)

PRODUCT_BRAND := meizu
PRODUCT_DEVICE := meizu_16sPro_CN
PRODUCT_MANUFACTURER := meizu
PRODUCT_NAME := lineage_meizu_16sPro_CN
PRODUCT_MODEL := 16s Pro

PRODUCT_GMS_CLIENTID_BASE := android-meizu
TARGET_VENDOR := meizu
TARGET_VENDOR_PRODUCT_NAME := meizu_16sPro_CN
PRODUCT_BUILD_PROP_OVERRIDES += PRIVATE_BUILD_DESC="meizu_16sPro_CN-user 9 PKQ1.190616.001 1564630973 release-keys"

# Set BUILD_FINGERPRINT variable to be picked up by both system and vendor build.prop
BUILD_FINGERPRINT := meizu/meizu_16sPro_CN/meizu16sPro:9/PKQ1.190616.001/1564630973:user/release-keys
