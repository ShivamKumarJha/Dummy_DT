#!/vendor/bin/sh
echo "clear battery health&safety data!"
echo "Starting...."

rm /factory/.bs
rm /factory/Batpercentage
rm /factory/bat_safety
rm /factory/bat_health_binary

echo "Ending Clear"
sync
