#!/bin/bash

mv /boot/{boot.cmd,boot.cmd.orig}
mv /boot/{boot.scr,boot.scr.orig}
cp /boot/boot.cmd.orig ./boot.cmd
patch -p1 < boot.cmd.patch
mkimage -C none -A arm -T script -d boot.cmd boot.scr
cp boot.* /boot

mv /boot/dtb/{sun8i-h3-nanopi-neo.dtb,sun8i-h3-nanopi-neo.dtb.orig}
dtc -I dtb -O dts -o sun8i-h3-nanopi-neo.dts /boot/dtb/sun8i-h3-nanopi-neo.dtb.orig
[[ $(uname -r) == 5.* ]] && patch -p1 < sun8i-h3-nanopi-neo.5.15.25.patch
[[ $(uname -r) == 4.* ]] && patch -p1 < sun8i-h3-nanopi-neo.dts.patch
dtc -I dts -O dtb -o sun8i-h3-nanopi-neo.dtb sun8i-h3-nanopi-neo.dts
cp sun8i-h3-nanopi-neo.dtb /boot/dtb
