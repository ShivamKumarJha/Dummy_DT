 #!/system/bin/sh

echo 0 > /proc/asusevtlog-switch
setprop persist.asuslog.fac.init 0
setprop persist.asus.mupload.enable 0
