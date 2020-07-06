#!/bin/sh
# SimpleArchInstaller (SAI) by glowiaK
echo "To use PL SAI for Intel create /dev/sda1 on swap"
echo "and /dev/sda2 on normal linux fs"
echo "preparing swap /dev/sda1..."
timedatectl set-ntp true
mkswap /dev/sda1
swapon /dev/sda1
echo "preparing ext3 on /dev/sda2"
mkfs.ext3 /dev/sda2
echo "mounting /dev/sda2 as /mnt..."
mount /dev/sda2 /mnt
echo "pacstrapping base system to /mnt..."
pacstrap /mnt base base-devel linux-linux-firmware
echo generating fstab...
genfstab -U /mnt >> /mnt/etc/fstab
echo "chrooting to /mnt..."
echo to complete installation run postchroot.sh
arch-chroot /mnt