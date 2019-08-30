#!/vendor/bin/sh

#Run initCDA
/system/bin/UpdateCDA -r -o /hidden/data/CDALog/ID
/system/bin/UpdateCDA -r -o /vendor/hidden/data/CDALog/ID
setprop sys.force.Idmap true
/system/bin/InitCDA -all