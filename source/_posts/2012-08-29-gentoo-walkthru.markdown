---
author: pnd4
comments: true
date: 2012-08-29 02:31:49
layout: post
slug: gentoo-walkthru
title: Hardened Gentoo Installation
wordpress_id: 125
categories:
- Computing
---

{% img center /images/2012-08-29-gentoo-walkthru/screenshot-082912-035809.png %}


*This time I power-walk you through each command to install Gentoo (using a Hardened Stage 3 toolchain). I used this same set of commands, with a little modification of course, to install Gentoo onto my desktop. My hardware configuration is very unlikely the same as yours; adjust accordingly, otherwise these instructions should be all you need to tackle one of the hardest distro's to install (by reputation).*

*And before you tl;dr, realize that even though the process is long and gruesome, there's so much to learn by just even trying, so do not dispair. There's tons of resources out there! Good luck.*





**Installing Hardened Gentoo with Xorg.**







Boot live media







Disable network manager if running



{% codeblock %}
# /etc/init.d/NetworkManager stop
{% endcodeblock %}



Connect to wireless



{% codeblock %}
# iwconfig wlan0 essid NETGEAR key s:yourmom
# ifconfig wlan0 192.168.1.100 netmask 255.255.255.0
# route add default gw 192.168.1.254
# ping -c 3 www.google.com
{% endcodeblock %}




Set root password



{% codeblock %}
# passwd root
{% endcodeblock %}




[now we switch to our remote computer]







SSH into the box we're install Gentoo onto



{% codeblock %}
# ssh 192.168.1.100 -l root
{% endcodeblock %}




Create partitions



{% codeblock %}
# fdisk /dev/sda
{% endcodeblock %}


They should look something like this:

{% codeblock %}
 /dev/sda1 1G Linux /boot
 /dev/sda2 4G Linux Swap /swap
 /dev/sda3 Rest Linux /root
{% endcodeblock %}




Create filesystems



{% codeblock %}
# mkfs.ext2 /dev/sda1 -L boot
# mkswap /dev/sda2 -L swap && swapon /dev/sda2
# mkfs.ext2 -j /dev/sda3 -L root
{% endcodeblock %}




Mount filesystems for install



{% codeblock %}
# mount /dev/sda3 /mnt/gentoo
# mkdir /mnt/gentoo/boot
# mount /dev/sda1 /mnt/gentoo/boot
{% endcodeblock %}




Download and extract latest stage 3



{% codeblock %}
# cd /mnt/gentoo
# wget http://ftp.ucsb.edu/pub/mirrors/linux/gentoo/releases/amd64/current-stage3/hardened/stage3-amd64-hardened-20120621.tar.bz2
# tar xjpf stage3-*
{% endcodeblock %}




Download and extract latest portage snapshot



{% codeblock %}
# cd /mnt/gentoo/usr
# wget http://ftp.ucsb.edu/pub/mirrors/linux/gentoo/releases/snapshots/current/portage-latest.tar.bz2
# tar xjf portage-latest.tar.bz2
{% endcodeblock %}




Mount relevant directories and chroot into new environment



{% codeblock %}
# cd /
# mount -t proc proc /mnt/gentoo/proc
# mount --rbind /dev /mnt/gentoo/dev
# cp -L /etc/resolv.conf /mnt/gentoo/etc
# chroot /mnt/gentoo /bin/bash
# env-update && source /etc/profile
{% endcodeblock %}




Configure time zone



{% codeblock %}
# ln -sf /usr/share/zoneinfo/America/Los_Angeles /etc/localtime
# echo "America/Los_Angeles" > /etc/timezone
# date
{% endcodeblock %}




Configure hostname and domain name



{% codeblock %}
# nano /etc/hosts
# nano /etc/conf.d/hostname
# hostname blackbox
# hostname -f
{% endcodeblock %}




Download and compile your kernel



{% codeblock %}
# emerge -av hardened-sources linux-firmware
# cd /usr/src/linux
# make menuconfig
{% endcodeblock %}


Make and install kernel and modules

{% codeblock %}
# make -j2
# make modules_install
# cp arch/x86_64/boot/bzImage /boot/kernel
# echo 'modules="ath9k_htc"' >> /etc/conf.d/modules
{% endcodeblock %}




Configure fstab



{% codeblock %}
# nano /etc/fstab

 /dev/sda1 /boot ext2 noauto,noatime 1 2
 /dev/sda2 none swap swap sw 0 0
 /dev/sda3 / ext3 noatime 0 1
 /dev/sr0 /mnt/cdrom auto 0 0

{% endcodeblock %}






Add sshd as a default service



{% codeblock %}
# rc-update add sshd default
{% endcodeblock %}




Set the root password



{% codeblock %}
# passwd root
{% endcodeblock %}




Install some recommended tools (syslog-ng, vixie-cron, wireless-tools, wpa_supplicant)



{% codeblock %}
# emerge -av syslog-ng vixie-cron wireless-tools wpa_supplicant
# rc-update add syslog-ng default
# rc-update add vixie-cron default
{% endcodeblock %}




Install and configure bootloader



{% codeblock %}
# emerge -av grub
# nano /boot/grub/grub.conf
**grub.conf**
default 0
timeout 10
title Gentoo
root (hd0,0)
kernel /boot/kernel root=/dev/sda3 video=800x600

# grub
>root (hd0,0)
>setup (hd0)
>quit
{% endcodeblock %}




Exit chroot, umount everything, and reboot



{% codeblock %}
# exit
# umount -l /mnt/gentoo/dev{/shm,/pts,}
# umount -l /mnt/gentoo{/proc,/boot,}
# reboot
{% endcodeblock %}




Add new user



{% codeblock %}
# useradd -g users -G lp,wheel,audio,cdrom,portage,cron -m somefag
# passwd somefag
{% endcodeblock %}




Sort mirrors



{% codeblock %}
# emerge mirrorselect
# mirrorselect -i -o >> /etc/portage/make.conf
# mirrorselect -i -r -o >> /etc/portage/make.conf
{% endcodeblock %}




Configure stuff in /etc/portage/make.conf



{% codeblock %}
MAKEOPTS="-j2"
USE= [fill in]
CFLAGS="-O2 -march=native -pipe"
VIDEO_CARDS="radeon"
INPUT_DEVICES="evdev synaptics"
{% endcodeblock %}




Uncomment and generate locales you're going to use



{% codeblock %}
# nano /etc/locale.gen
# locale-gen
{% endcodeblock %}




Re-emerge world, libtool



{% codeblock %}
# emerge -vuD --newuse world
# emerge --oneshot libtool
{% endcodeblock %}




Update config (do not overwrite the files you've done your own editing to)



{% codeblock %}
# dispatch-conf
{% endcodeblock %}




_(Optional, if Perl or Python got updated, but doesnt hurt)_




Run perl-cleaner and python-updater



{% codeblock %}
# perl-cleaner all
# python-updater
{% endcodeblock %}




Install xorg



{% codeblock %}
# emerge -av xorg-server
# env-update && source /etc/profile
{% endcodeblock %}


and.. voilà!

_Continue by customizing your install with a browser, file manager, window manager, or be lazy and just get a whole desktop environment. Have fun making any necessary tweaks to file's we've already used, like make.conf USE flags, kernel configuration, bootloader.. but be happy, if you've got this far, you've got a working system._
