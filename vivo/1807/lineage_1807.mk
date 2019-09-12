# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Lineage stuff
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from 1807 device
$(call inherit-product, $(LOCAL_PATH)/device.mk)

PRODUCT_BRAND := vivo
PRODUCT_DEVICE := 1807
PRODUCT_MANUFACTURER := vivo
PRODUCT_NAME := lineage_1807
PRODUCT_MODEL := vivo 1807

PRODUCT_GMS_CLIENTID_BASE := android-vivo
TARGET_VENDOR := vivo
TARGET_VENDOR_PRODUCT_NAME := 1807
PRODUCT_BUILD_PROP_OVERRIDES += PRIVATE_BUILD_DESC="msm8937_64-user 8.1.0 OPM1.171019.026 eng.compil.20190506.185247 release-keys"

# Set BUILD_FINGERPRINT variable to be picked up by both system and vendor build.prop
BUILD_FINGERPRINT := vivo/1807/1807:8.1.0/OPM1.171019.026/compil05061852:user/release-keys
