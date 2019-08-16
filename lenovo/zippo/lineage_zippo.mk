# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Lineage stuff
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from zippo device
$(call inherit-product, $(LOCAL_PATH)/device.mk)

PRODUCT_BRAND := lenovo
PRODUCT_DEVICE := zippo
PRODUCT_MANUFACTURER := lenovo
PRODUCT_NAME := lineage_zippo
PRODUCT_MODEL := Lenovo Z6 Pro

PRODUCT_GMS_CLIENTID_BASE := android-lenovo
TARGET_VENDOR := lenovo
TARGET_VENDOR_PRODUCT_NAME := zippo
PRODUCT_BUILD_PROP_OVERRIDES += PRIVATE_BUILD_DESC="zippo_row-user 9 PKQ1.190110.001 11.0.284_190810 release-keys"

# Set BUILD_FINGERPRINT variable to be picked up by both system and vendor build.prop
BUILD_FINGERPRINT := Lenovo/zippo_row/zippo:9/PKQ1.190110.001/11.0.284_190810:user/release-keys
