PRODUCT_PROPERTY_OVERRIDES += \
    af.fast_track_multiplier=1 \
    audio.deep_buffer.media=true \
    audio.offload.min.duration.secs=30 \
    audio.offload.video=false \
    av.debug.disable.pers.cache=1 \
    persist.vendor.audio.fluence.speaker=true \
    persist.vendor.audio.fluence.voicecall=true \
    persist.vendor.audio.fluence.voicerec=false \
    persist.vendor.audio.speaker.prot.enable=false \
    persist.vendor.radio.add_power_save=1 \
    ro.vendor.audio.sdk.fluencetype=none \
    ro.vendor.audio.sdk.ssr=false \
    vendor.audio.dolby.ds2.enabled=false \
    vendor.audio.dolby.ds2.hardbypass=false \
    vendor.audio.flac.sw.decoder.24bit=true \
    vendor.audio.hw.aac.encoder=false \
    vendor.audio.offload.buffer.size.kb=64 \
    vendor.audio.offload.gapless.enabled=true \
    vendor.audio.offload.multiaac.enable=true \
    vendor.audio.offload.multiple.enabled=false \
    vendor.audio.offload.passthrough=false \
    vendor.audio.offload.track.enable=false \
    vendor.audio.parser.ip.buffer.size=262144 \
    vendor.audio.playback.mch.downsample=true \
    vendor.audio.pp.asphere.enabled=false \
    vendor.audio.safx.pbe.enabled=true \
    vendor.audio.tunnel.encode=false \
    vendor.audio.use.sw.alac.decoder=true \
    vendor.audio.use.sw.ape.decoder=true \
    vendor.audio_hal.period_size=192 \
    vendor.voice.conc.fallbackpath=deep-buffer \
    vendor.voice.path.for.pcm.voip=true \
    vendor.voice.playback.conc.disabled=true \
    vendor.voice.record.conc.disabled=false \
    vendor.voice.voip.conc.disabled=true \
    bluetooth.hfp.client=1 \
    persist.vendor.bt.enable.splita2dp=false \
    qcom.bluetooth.soc=pronto \
    ro.qualcomm.bt.hci_transport=smd \
    persist.cne.feature=1 \
    camera.hal1.packagelist=com.skype.raider,com.google.android.talk \
    camera.lowpower.record.enable=1 \
    persist.vendor.camera.display.lmax=1280x720 \
    persist.vendor.camera.display.umax=1920x1080 \
    ro.cutoff_voltage_mv=3400 \
    persist.vendor.dpm.feature=11 \
    dalvik.vm.heapgrowthlimit=256m \
    dalvik.vm.heapmaxfree=8m \
    dalvik.vm.heapminfree=4m \
    dalvik.vm.heapsize=512m \
    dalvik.vm.heapstartsize=16m \
    dalvik.vm.heaptargetutilization=0.75 \
    ro.fm.transmitter=false \
    ro.frp.pst=/dev/block/bootdevice/by-name/config \
    persist.fuse_sdcard=true \
    debug.egl.hw=0 \
    debug.gralloc.enable_fb_ubwc=1 \
    debug.sf.disable_backpressure=1 \
    debug.sf.enable_hwc_vds=1 \
    debug.sf.hw=0 \
    debug.sf.latch_unsignaled=1 \
    dev.pm.dyn_samplingrate=1 \
    persist.demo.hdmirotationlock=false \
    ro.opengles.version=196610 \
    ro.sf.lcd_density=440 \
    vendor.display.enable_default_color_mode=1 \
    media.aac_51_output_enabled=true \
    media.msm8956hw=0 \
    media.settings.xml=/vendor/etc/media_profiles_vendor.xml \
    mm.enable.qcom_parser=1048575 \
    mm.enable.smoothstreaming=true \
    mmp.enable.3g2=true \
    persist.mm.sta.enable=0 \
    ro.emmc_size=16GB \
    ro.qualcomm.cabl=0 \
    vendor.vidc.dec.downscalar_height=1088 \
    vendor.vidc.dec.downscalar_width=1920 \
    vendor.vidc.disable.split.mode=1 \
    vendor.vidc.enc.disable.pq=true \
    vendor.vidc.enc.disable_bframes=1 \
    vidc.enc.dcvs.extra-buff-count=2 \
    config.disable_consumerir=true \
    debug.enable.gamed=0 \
    debug.enable.sglscale=1 \
    debug.mdpcomp.logs=0 \
    import \
    /oem/oem.prop \
    keyguard.no_require_sim=true \
    persist.console.silent.config=1 \
    persist.debug.coresight.config=stm-events \
    persist.hwc.enable_vds=1 \
    persist.hwc.mdpcomp.enable=true \
    persist.qfp=false \
    persist.sys.disable_rescue=true \
    persist.vendor.ims.dropset_feature=0 \
    qemu.hw.mainkeys=0 \
    ro.config.message_sound=Default.ogg \
    ro.kernel.android.checkjni=0 \
    ro.lineage.build.vendor_security_patch=2019-05-01 \
    ro.hardware.nfc_nci=nqx.default \
    persist.data.mode=concurrent \
    persist.data.netmgrd.qos.enable=true \
    ro.use_data_netmgrd=true \
    ro.memperf.enable=false \
    ro.memperf.lib=libmemperf.so \
    ro.vendor.extension_library=libqti-perfd-client.so \
    persist.vendor.qti.telephony.vt_cam_interface=1 \
    ro.vendor.at_library=libqti-at.so \
    ro.vendor.gt_library=libqti-gt.so \
    ro.vendor.qti.am.reschedule_service=true \
    ro.vendor.qti.config.zram=true \
    ro.vendor.qti.core_ctl_max_cpu=4 \
    ro.vendor.qti.core_ctl_min_cpu=2 \
    ro.vendor.qti.sys.fw.bservice_age=5000 \
    ro.vendor.qti.sys.fw.bservice_enable=true \
    ro.vendor.qti.sys.fw.bservice_limit=5 \
    ro.vendor.qti.sys.fw.empty_app_percent=50 \
    ro.vendor.qti.sys.fw.trim_cache_percent=100 \
    ro.vendor.qti.sys.fw.trim_empty_percent=100 \
    ro.vendor.qti.sys.fw.trim_enable_memory=2147483648 \
    ro.vendor.qti.sys.fw.use_trim_settings=true \
    DEVICE_PROVISIONED=1 \
    persist.data.profile_update=true \
    persist.radio.apm_sim_not_pwdn=1 \
    persist.radio.multisim.config=dsds \
    persist.radio.schd.cache=3500 \
    persist.vendor.radio.custom_ecc=1 \
    persist.vendor.radio.force_on_dc=true \
    persist.vendor.radio.mt_sms_ack=30 \
    persist.vendor.radio.poweron_opt=1 \
    persist.vendor.radio.process_sups_ind=1 \
    persist.vendor.radio.rat_on=combine \
    persist.vendor.radio.relay_oprt_change=1 \
    persist.vendor.radio.report_codec=1 \
    persist.vendor.radio.sib16_support=1 \
    persist.vendor.radio.start_ota_daemon=1 \
    ril.subscription.types=NV,RUIM \
    rild.libargs=-d /dev/smd0 \
    rild.libpath=/vendor/lib64/libril-qc-qmi-1.so \
    ro.carrier=unknown \
    ro.com.android.dataroaming=false \
    ro.ril.dtmf_interval=200 \
    ro.ril.dtmf_pause_interval=100 \
    ro.telephony.default_network=22,20 \
    telephony.lteOnCdmaDevice=1 \
    ro.build.shutdown_timeout=0 \
    ro.build.shutdown_timeout=4 \
    sys.vendor.shutdown.waittime=500 \
    sdm.debug.disable_skip_validate=1 \
    persist.timed.enable=true \
    ro.sys.usb.default.config=diag,serial_smd,rmnet_ipa,adb \
    persist.debug.wfd.enable=1 \