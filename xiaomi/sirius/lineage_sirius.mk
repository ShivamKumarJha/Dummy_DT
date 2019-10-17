# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Lineage stuff
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from sirius device
$(call inherit-product, $(LOCAL_PATH)/device.mk)

PRODUCT_BRAND := xiaomi
PRODUCT_DEVICE := sirius
PRODUCT_MANUFACTURER := xiaomi
PRODUCT_NAME := lineage_sirius
PRODUCT_MODEL := MI 8 SE

PRODUCT_GMS_CLIENTID_BASE := android-xiaomi
TARGET_VENDOR := xiaomi
TARGET_VENDOR_PRODUCT_NAME := sirius
PRODUCT_BUILD_PROP_OVERRIDES += PRIVATE_BUILD_DESC="sirius-user 9 PKQ1.181121.001 V11.0.3.0.PEBCNXM release-keys"

# Set BUILD_FINGERPRINT variable to be picked up by both system and vendor build.prop
BUILD_FINGERPRINT := Xiaomi/sirius/sirius:9/PKQ1.181121.001/V11.0.3.0.PEBCNXM:user/release-keys
