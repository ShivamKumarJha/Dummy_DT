# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Lineage stuff
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from RMX1853 device
$(call inherit-product, $(LOCAL_PATH)/device.mk)

PRODUCT_BRAND := realme
PRODUCT_DEVICE := RMX1853
PRODUCT_MANUFACTURER := realme
PRODUCT_NAME := lineage_RMX1853
PRODUCT_MODEL := realme 3 Pro

PRODUCT_GMS_CLIENTID_BASE := android-realme
TARGET_VENDOR := realme
TARGET_VENDOR_PRODUCT_NAME := RMX1853
PRODUCT_BUILD_PROP_OVERRIDES += PRIVATE_BUILD_DESC="sdm710-user 9 PKQ1.190101.001 eng.root.20190724.184842 release-keys"

# Set BUILD_FINGERPRINT variable to be picked up by both system and vendor build.prop
BUILD_FINGERPRINT := sdm710-user-9-PKQ1.190101.001-eng.root.20190724.184842-release-keys
