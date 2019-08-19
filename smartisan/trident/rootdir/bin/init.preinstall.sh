#!/vendor/bin/sh

## part 1, pre-install app
cd /vendor/media/app
var=`getprop persist.smartisan.preinstalled 2>&1`
var2=`getprop persist.smartisan.preicon 2>&1`

if [ "$var" != "y" ]; then
    var=`getprop persist.smartisan_apk.preinstalled 2>&1`
    var2=`getprop persist.smartisan_apk.preicon 2>&1`
fi

#android shell script: check if preinstall is exist
if [ "$var" = "y" ]; then
    echo "don't need to copy preinstall files"
else
    # scan all apk files under vendor/media/app
    apklist="$(ls)"
    for apkfile in ${apklist}; do
        #copy all apk file to data/app
        mkdir /data/app/${apkfile%.apk*}
        cp ${apkfile} /data/app/${apkfile%.apk*}/${apkfile}
        # change the permission
        chown 1000:1000 /data/app/${apkfile%.apk*}
        chown 1000:1000 /data/app/${apkfile%.apk*}/${apkfile}
        chmod 755 /data/app/${apkfile%.apk*}/
        chmod 644 /data/app/${apkfile%.apk*}/${apkfile}
    done
    setprop persist.smartisan_apk.preinstalled  y
fi

if [ -d "/cache/app" ]; then
    cp /cache/app/* /data/app
    if [ -f "/data/app/Phonesky.apk" ]; then
        chown -R 1000:1000 /data/app
        chmod 644 -R /data/app/*.apk
        rm -rf /cache/app
    fi
fi

# part 2, pre-install icon
if [ "$var2" = "y" ]; then
    echo "don't need to copy pre-install icons"
else
    mkdir /data/system/icon
    chown 1000:1000 /data/system/icon
    chmod 775 /data/system/icon

    cd /vendor/media/icon
    pkglist="$(ls)"
    for pkg in ${pkglist}; do
        if [ ! -d /data/system/icon/${pkg} ]; then
            mkdir /data/system/icon/${pkg}
            chown 1000:1000 /data/system/icon/${pkg}
            chmod 775 /data/system/icon/${pkg}
            cd /vendor/media/icon/${pkg}
            filelist="$(ls)"
            for file in ${filelist}; do
                cp ${file} /data/system/icon/${pkg}/${file}
                chown 1000:1000 /data/system/icon/${pkg}/${file}
                chmod 644 /data/system/icon/${pkg}/${file}
            done
        fi
    done
    setprop persist.smartisan_apk.preicon y
fi
