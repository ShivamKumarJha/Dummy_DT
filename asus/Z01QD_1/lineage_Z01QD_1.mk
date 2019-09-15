# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Lineage stuff
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from Z01QD_1 device
$(call inherit-product, $(LOCAL_PATH)/device.mk)

PRODUCT_BRAND := asus
PRODUCT_DEVICE := Z01QD_1
PRODUCT_MANUFACTURER := asus
PRODUCT_NAME := lineage_Z01QD_1
PRODUCT_MODEL := ASUS_Z01QD

PRODUCT_GMS_CLIENTID_BASE := android-asus
TARGET_VENDOR := asus
TARGET_VENDOR_PRODUCT_NAME := Z01QD_1
PRODUCT_BUILD_PROP_OVERRIDES += PRIVATE_BUILD_DESC="CN_Phone-user 8.1.0 OPM1.171019.026 15.1630.1907.98-0 release-keys"

# Set BUILD_FINGERPRINT variable to be picked up by both system and vendor build.prop
BUILD_FINGERPRINT := asus/CN_Z01QD/ASUS_Z01QD_1:8.1.0/OPM1.171019.026/15.1630.1907.98-0:user/release-keys
