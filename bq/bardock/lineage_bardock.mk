# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Lineage stuff
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from bardock device
$(call inherit-product, $(LOCAL_PATH)/device.mk)

PRODUCT_BRAND := bq
PRODUCT_DEVICE := bardock
PRODUCT_MANUFACTURER := bq
PRODUCT_NAME := lineage_bardock
PRODUCT_MODEL := Aquaris X

PRODUCT_GMS_CLIENTID_BASE := android-bq
TARGET_VENDOR := bq
TARGET_VENDOR_PRODUCT_NAME := bardock
PRODUCT_BUILD_PROP_OVERRIDES += PRIVATE_BUILD_DESC="bardock_bq-user 8.1.0 OPM1.171019.026 2168 release-keys"

# Set BUILD_FINGERPRINT variable to be picked up by both system and vendor build.prop
BUILD_FINGERPRINT := bq/bardock/bardock:8.1.0/OPM1.171019.026/2168:user/release-keys
