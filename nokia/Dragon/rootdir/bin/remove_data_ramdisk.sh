mkdir /mnt/tmpfs
mount -t tmpfs -o size=1000m none /mnt/tmpfs
cp -rf --preserve=a /data/preload-app/* /mnt/tmpfs/
umount /data
make_ext4fs dev/block/bootdevice/by-name/userdata
mount -t ext4 dev/block/bootdevice/by-name/userdata /data
mkdir /data/preload-app
cp -rf --preserve=a /mnt/tmpfs/* /data/preload-app/