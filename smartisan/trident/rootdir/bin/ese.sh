#!/system/bin/sh
echo -e "spi test"
nfcspitest
echo -e "ese test"
pnx --mcc 0x0D
pnx --sst
