PRODUCT_PROPERTY_OVERRIDES += \
    rild.libargs=-d /dev/umts_ipc0 \
    debug.egl.hw=0 \
    debug.gralloc.enable_fb_ubwc=1 \
    debug.sf.enable_hwc_vds=1 \
    debug.sf.hw=0 \
    debug.sf.latch_unsignaled=1 \
    persist.demo.hdmirotationlock=false \
    ro.sf.lcd_density=440 \
    vendor.display.enable_default_color_mode=1 \
    import \
    /efs/factory.prop \
    persist.hwc.enable_vds=1 \
    ro.arch=msm8937_32 \
    ro.debug_level=0x494d \
    ro.kernel.qemu.gles=2 \
    ro.multisim.simslotcount=2 \
    sys.config.phone_start_early=true \
    sys.disable_ext_animation=1 \
    rild.libpath=/system/lib64/libsec-ril.so \
    ro.telephony.default_network=9 \
    sdm.debug.disable_skip_validate=1 \
    dev.usbsetting.embedded=on \
