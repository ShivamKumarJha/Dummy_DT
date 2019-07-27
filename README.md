Dummy Device Tree
=================
Output from bash [scripts](https://github.com/ShivamKumarJha/android_tools) to prepare following of a target ROM:
1. **proprietary-files-system.txt:** /system proprietary blobs list.
2. **proprietary-files.txt:** Both /system & /vendor proprietary blobs list.
3. **system_prop.mk:** Properties from /system/build.prop.
4. **vendor_prop.mk:** Properties from /system & /vendor build.prop.
5. **configs:** From both /system & /vendor. Makefile generated.
6. **rootdir:** Ramdisk with generated Makefile.
7. **overlay:** FWB configs, Bluetooth & CarrierConfig
8. **skeleton tree**

#### Note:
These files **will** require edits but will certainly **save you a lot of time**.
This repo is to help reduce time taken during device bringup or updating firmware. If you don't know what you're doing, this is not going to help you.
Can also be referred to observe files changed after ROM upgrade.

##### Requesting new device:
Extract & push ROM using this [script](https://github.com/AndroidDumps/dumpyara).

**Channel**: [Telegram](https://t.me/dummy_dt)
