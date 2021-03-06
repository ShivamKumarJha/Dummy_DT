PRODUCT_PROPERTY_OVERRIDES += \
    af.fast_track_multiplier=1 \
    audio.deep_buffer.media=true \
    audio.offload.buffer.size.kb=32 \
    audio.offload.gapless.enabled=true \
    audio.offload.min.duration.secs=30 \
    audio.offload.video=false \
    audio.offload.video=true \
    av.offload.enable=true \
    persist.audio.fluence.speaker=true \
    persist.audio.fluence.voicecall=true \
    persist.audio.fluence.voicerec=false \
    persist.vendor.audio.avs.afe_api_version=2 \
    persist.vendor.audio.fluence.audiorec=false \
    persist.vendor.audio.fluence.speaker=true \
    persist.vendor.audio.fluence.tmic.enabled=false \
    persist.vendor.audio.fluence.voicecall=true \
    persist.vendor.audio.fluence.voicerec=false \
    persist.vendor.audio.hifi.int_codec=true \
    persist.vendor.audio.ras.enabled=false \
    persist.vendor.audio.spv3.enable=true \
    persist.vendor.radio.add_power_save=1 \
    ro.af.client_heap_size_kbyte=7168 \
    ro.qc.sdk.audio.fluencetype=none \
    ro.qc.sdk.audio.ssr=false \
    ro.vendor.audio.sdk.fluencetype=none \
    ro.vendor.audio.sdk.ssr=false \
    tunnel.audio.encode = true \
    use.voice.path.for.pcm.voip=true \
    vendor.audio.apptype.multirec.enabled=false \
    vendor.audio.dolby.ds2.enabled=false \
    vendor.audio.dolby.ds2.hardbypass=false \
    vendor.audio.flac.sw.decoder.24bit=true \
    vendor.audio.hw.aac.encoder=false \
    vendor.audio.noisy.broadcast.delay=600 \
    vendor.audio.offload.buffer.size.kb=64 \
    vendor.audio.offload.gapless.enabled=true \
    vendor.audio.offload.multiaac.enable=true \
    vendor.audio.offload.multiple.enabled=false \
    vendor.audio.offload.passthrough=false \
    vendor.audio.offload.pstimeout.secs=3 \
    vendor.audio.offload.track.enable=false \
    vendor.audio.parser.ip.buffer.size=262144 \
    vendor.audio.record.multiple.enabled=false \
    vendor.audio.safx.pbe.enabled=true \
    vendor.audio.tunnel.encode=false \
    vendor.audio.use.sw.alac.decoder=true \
    vendor.audio.use.sw.ape.decoder=true \
    vendor.audio_hal.period_size=192 \
    vendor.voice.path.for.pcm.voip=true \
    bt.max.hfpclient.connections=1 \
    persist.vendor.bt.a2dp_offload_cap=sbc-aptx-aptxhd-aac-ldac \
    persist.vendor.btstack.a2dp_offload_cap=sbc-aptx-aptxtws-aptxhd-aac-ldac \
    persist.vendor.btstack.enable.splita2dp=true \
    ro.bluetooth.emb_wp_mode=false \
    ro.bluetooth.library_name=libbluetooth_qti.so \
    ro.bluetooth.wipower=false \
    vendor.bluetooth.soc=cherokee \
    vendor.qcom.bluetooth.soc=cherokee \
    persist.vendor.cne.feature=1 \
    persist.vendor.camera.privapp.list=com.android.camera \
    vendor.camera.aux.packagelist=org.codeaurora.snapcam,com.android.camera,com.vivo.bsptest,com.iqoo.engineermode \
    persist.chg.max_volt_mv=9000 \
    persist.vendor.dpm.feature=11 \
    dalvik.vm.heapgrowthlimit=256m \
    dalvik.vm.heapmaxfree=8m \
    dalvik.vm.heapminfree=512k \
    dalvik.vm.heapsize=512m \
    dalvik.vm.heapstartsize=8m \
    dalvik.vm.heaptargetutilization=0.75 \
    ro.dalvik.vm.native.bridge=0 \
    media.stagefright.enable-fma2dp=true \
    vendor.hw.fm.init=0 \
    ro.frp.pst=/dev/block/bootdevice/by-name/frp \
    persist.fuse_sdcard=true \
    debug.egl.hw=0 \
    debug.gralloc.gfx_ubwc_disable=0 \
    debug.sf.enable_hwc_vds=1 \
    debug.sf.hw=0 \
    debug.sf.latch_unsignaled=1 \
    dev.pm.dyn_samplingrate=1 \
    persist.demo.hdmirotationlock=false \
    ro.opengles.version=196610 \
    ro.sf.lcd_density=440 \
    ro.vendor.display.cabl=2 \
    vendor.display.builtin_mirroring=false \
    ro.location.osnlp.package=com.google.android.gms \
    ro.location.osnlp.region.package=com.baidu.map.location \
    media.aac_51_output_enabled=true \
    media.settings.xml=/vendor/etc/media_profiles_vendor.xml \
    media.stagefright.enable-aac=true \
    media.stagefright.enable-http=true \
    media.stagefright.enable-player=true \
    media.stagefright.enable-qcp=true \
    media.stagefright.enable-scan=true \
    mm.enable.smoothstreaming=true \
    mmp.enable.3g2=true \
    persist.mm.enable.prefetch=true \
    qcom.hw.aac.encoder=true \
    vendor.mm.enable.qcom_parser=13631487 \
    config.disable_consumerir=true \
    config.disable_rtt=true \
    import \
    /oem/oem.prop \
    keyguard.no_require_sim=true \
    persist.debug.coresight.config=stm-events \
    persist.rmnet.data.enable=true \
    persist.sys.disable_rescue=true \
    persist.vendor.data.profile_update=true \
    persist.vendor.ims.dropset_feature=0 \
    persist.vendor.qcomsysd.enabled=1 \
    qemu.hw.mainkeys=0 \
    ro.config.message_sound=Default.ogg \
    ro.hardware.keystore_desede=true \
    ro.kernel.android.checkjni=0 \
    ro.kernel.qemu.gles=0 \
    ro.vendor.iocgrp.config=1 \
    sdm.drop_skewed_vsync=1 \
    sys.autosuspend.timeout=500000 \
    sys.qca1530=detect \
    ro.hardware.nfc_nci=nqx.default \
    ro.nfc.port=I2C \
    persist.backup.ntpServer=0.pool.ntp.org \
    ro.netflix.bsp_rev=Q670-14477-1 \
    persist.data.netmgrd.qos.enable=true \
    persist.vendor.data.mode=concurrent \
    persist.vivo.data_netmgrd_mtu=1400 \
    ro.vendor.use_data_netmgrd=true \
    ro.vendor.extension_library=libqti-perfd-client.so \
    debug.vendor.qti.enable.lm=1 \
    persist.vendor.qti.games.gt.prof=1 \
    ro.vendor.at_library=libqti-at.so \
    ro.vendor.qti.config.zram=true \
    ro.vendor.qti.core_ctl_max_cpu=6 \
    ro.vendor.qti.core_ctl_min_cpu=4 \
    ro.vendor.qti.sys.fw.bg_apps_limit=60 \
    DEVICE_PROVISIONED=1 \
    persist.data.df.agg.dl_pkt=10 \
    persist.data.df.agg.dl_size=4096 \
    persist.data.df.dev_name=rmnet_usb0 \
    persist.data.df.dl_mode=5 \
    persist.data.df.iwlan_mux=9 \
    persist.data.df.mux_count=8 \
    persist.data.df.ul_mode=5 \
    persist.data.wda.enable=true \
    persist.radio.multisim.config=dsds \
    persist.vendor.radio.apm_sim_not_pwdn=1 \
    persist.vendor.radio.atfwd.start=true \
    persist.vendor.radio.cs_srv_type=true \
    persist.vendor.radio.custom_ecc=1 \
    persist.vendor.radio.force_on_dc=true \
    persist.vendor.radio.mt_sms_ack=30 \
    persist.vendor.radio.poweron_opt=1 \
    persist.vendor.radio.process_sups_ind=1 \
    persist.vendor.radio.rat_on=combine \
    persist.vendor.radio.relay_oprt_change=1 \
    persist.vendor.radio.report_codec=1 \
    persist.vendor.radio.sib16_support=1 \
    ril.subscription.types=NV,RUIM \
    rild.libpath=/vendor/lib64/libril-qc-hal-qmi.so \
    ro.carrier=unknown \
    ro.com.android.dataroaming=false \
    ro.telephony.default_network=22,20 \
    telephony.lteOnCdmaDevice=1 \
    sys.vendor.shutdown.waittime=500 \
    persist.timed.enable=true \
    persist.debug.wfd.enable=1 \
    persist.sys.wfd.virtual=0 \
