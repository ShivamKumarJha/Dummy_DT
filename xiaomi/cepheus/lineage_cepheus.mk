# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Lineage stuff
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from cepheus device
$(call inherit-product, $(LOCAL_PATH)/device.mk)

PRODUCT_BRAND := xiaomi
PRODUCT_DEVICE := cepheus
PRODUCT_MANUFACTURER := xiaomi
PRODUCT_NAME := lineage_cepheus
PRODUCT_MODEL := MI 9

PRODUCT_GMS_CLIENTID_BASE := android-xiaomi
TARGET_VENDOR := xiaomi
TARGET_VENDOR_PRODUCT_NAME := cepheus
PRODUCT_BUILD_PROP_OVERRIDES += PRIVATE_BUILD_DESC="cepheus-user 10 QKQ1.190716.003 V11.0.2.0.QFACNXM release-keys"

# Set BUILD_FINGERPRINT variable to be picked up by both system and vendor build.prop
BUILD_FINGERPRINT := Xiaomi/cepheus/cepheus:10/QKQ1.190716.003/V11.0.2.0.QFACNXM:user/release-keys
