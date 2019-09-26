# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Lineage stuff
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from msm8909_512go device
$(call inherit-product, $(LOCAL_PATH)/device.mk)

PRODUCT_BRAND := coolpad
PRODUCT_DEVICE := msm8909_512go
PRODUCT_MANUFACTURER := coolpad
PRODUCT_NAME := lineage_msm8909_512go
PRODUCT_MODEL := 3311A

PRODUCT_GMS_CLIENTID_BASE := android-coolpad
TARGET_VENDOR := coolpad
TARGET_VENDOR_PRODUCT_NAME := msm8909_512go
PRODUCT_BUILD_PROP_OVERRIDES += PRIVATE_BUILD_DESC="msm8909_512go-user 8.1.0 OPM1.171019.026 eng.builde.20180623.215200 test-keys"

# Set BUILD_FINGERPRINT variable to be picked up by both system and vendor build.prop
BUILD_FINGERPRINT := qcom/msm8909_512go/msm8909_512go:8.1.0/OPM1.171019.026/builde06232152:user/test-keys
