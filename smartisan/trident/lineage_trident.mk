# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Lineage stuff
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from trident device
$(call inherit-product, $(LOCAL_PATH)/device.mk)

PRODUCT_BRAND := smartisan
PRODUCT_DEVICE := trident
PRODUCT_MANUFACTURER := smartisan
PRODUCT_NAME := lineage_trident
PRODUCT_MODEL := DE106

PRODUCT_GMS_CLIENTID_BASE := android-smartisan
TARGET_VENDOR := smartisan
TARGET_VENDOR_PRODUCT_NAME := trident
PRODUCT_BUILD_PROP_OVERRIDES += PRIVATE_BUILD_DESC="trident-user 8.1.0 OPM1.171019.026 58 dev-keys"

# Set BUILD_FINGERPRINT variable to be picked up by both system and vendor build.prop
BUILD_FINGERPRINT := SMARTISAN/trident/trident:8.1.0/OPM1.171019.026/1537375010:user/dev-keys
