# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Lineage stuff
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from vela device
$(call inherit-product, $(LOCAL_PATH)/device.mk)

PRODUCT_BRAND := meitu
PRODUCT_DEVICE := vela
PRODUCT_MANUFACTURER := meitu
PRODUCT_NAME := lineage_vela
PRODUCT_MODEL := MI CC 9 Meitu Edition

PRODUCT_GMS_CLIENTID_BASE := android-meitu
TARGET_VENDOR := meitu
TARGET_VENDOR_PRODUCT_NAME := vela
PRODUCT_BUILD_PROP_OVERRIDES += PRIVATE_BUILD_DESC="vela-user 9 PKQ1.181121.001 V10.3.8.0.PFECNXM release-keys"

# Set BUILD_FINGERPRINT variable to be picked up by both system and vendor build.prop
BUILD_FINGERPRINT := Meitu/vela/vela:9/PKQ1.181121.001/V10.3.8.0.PFECNXM:user/release-keys
