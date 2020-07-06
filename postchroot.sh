echo setting locale to Warsaw...
ln -sf /usr/share/zoneinfo/Europe/Warsaw /etc/localtime
hwclock --systohc
locale-gen
pacman -S nano
echo pl_PL.UTF-8 >> /etc/locale.gen
echo LANG=pl_PL.UTF-8 >> /etc/locale.conf
export LANG=pl_PL.UTF-8
echo FONT=Lat2-Terminus16.psfu.gz >> /etc/vconsole.conf
echo FONT_MAP=8859-2 >> /etc/vconsole.conf
echo setting hosts...
echo -n "Computer's hostname: "
read hostn
echo ${hostn} >> /etc/hostname
echo "127.0.0.1		localhost" >> /etc/hosts
echo "::1		localhost" >> /etc/hosts
echo "127.0.1.1		${hostn}.localdomain ${hostn}" >> /etc/hosts
echo enabling multilib repository....
echo "[multilib]" >> /etc/pacman.conf
echo "Include = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf
echo Installing Intel drivers, xorg, chromium and xfce4...
pacman -Syu xf86-video-amdgpu mesa xf86-input-synaptics xf86-video-intel
pacman -S xorg-server xf86-input-evdev xf86-video-vesa xorg-apps xterm
pacman -S chromium
pacman -S xfce4 xfce4-goodies
pacman -S sddm
systemctl enable sddm
echo Installing sound drivers...
pacman -S alsa-firmware alsa-lib alsa-plugins alsa-utils pulseaudio pulseaudio-alsa libcanberra libcanberra-pulse
echo creating linux image...
mkinitcpio -P
echo Set root password:
passwd
echo -n "New User Name: "
read usernamem
useradd -m -g users -G wheel,storage,power -s /bin/sh ${usernamem}
echo setting password for ${usernamem}:
passwd ${usernamem}
echo installing sudo...
pacman -S sudo
echo installing and configuring grub...
pacman -S grub
grub-install --recheck /dev/sda
pacman -S os-prober
grub-mkconfig -o /boot/grub/grub.cfg
pacman -S xterm
pacman -S net-tools
pacman -S dhcpcd
echo Type:
echo "exit"
echo "umount -a"
echo "reboot"
echo Installation complete!