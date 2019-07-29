# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Lineage stuff
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from mermaid_dsds device
$(call inherit-product, $(LOCAL_PATH)/device.mk)

PRODUCT_BRAND := sony
PRODUCT_DEVICE := mermaid_dsds
PRODUCT_MANUFACTURER := sony
PRODUCT_NAME := lineage_mermaid_dsds
PRODUCT_MODEL := Xperia 10 Plus

PRODUCT_GMS_CLIENTID_BASE := android-sony
TARGET_VENDOR := sony
TARGET_VENDOR_PRODUCT_NAME := mermaid_dsds
PRODUCT_BUILD_PROP_OVERRIDES += PRIVATE_BUILD_DESC="mermaid_dsds-user 9 P-GANGES-CAF-181216-1906 1 dev-keys"

# Set BUILD_FINGERPRINT variable to be picked up by both system and vendor build.prop
BUILD_FINGERPRINT := Sony/mermaid_dsds/mermaid_dsds:9/P-GANGES-CAF-181216-1906/1:user/dev-keys
