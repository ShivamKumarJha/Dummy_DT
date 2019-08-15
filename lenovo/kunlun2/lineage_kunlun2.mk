# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Lineage stuff
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from kunlun2 device
$(call inherit-product, $(LOCAL_PATH)/device.mk)

PRODUCT_BRAND := lenovo
PRODUCT_DEVICE := kunlun2
PRODUCT_MANUFACTURER := lenovo
PRODUCT_NAME := lineage_kunlun2
PRODUCT_MODEL := Lenovo K10 Note

PRODUCT_GMS_CLIENTID_BASE := android-lenovo
TARGET_VENDOR := lenovo
TARGET_VENDOR_PRODUCT_NAME := kunlun2
PRODUCT_BUILD_PROP_OVERRIDES += PRIVATE_BUILD_DESC="kunlun2_row-user 9 PKQ1.190127.001 11.0.092_190719 release-keys"

# Set BUILD_FINGERPRINT variable to be picked up by both system and vendor build.prop
BUILD_FINGERPRINT := Lenovo/kunlun2_row/kunlun2:9/PKQ1.190127.001/11.0.092_190719:user/release-keys
