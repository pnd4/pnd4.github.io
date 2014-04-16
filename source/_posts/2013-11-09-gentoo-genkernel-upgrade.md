---
layout: post
title: Gentoo - Genkernel Upgrade Steps
categories: 
- Computing
---
*I use genkernel to install my kernel.. this isn't the best way to do things but for now it gets the job done. Gentoo isn't my primary distro so I sometimes forget the steps to go through when they push a new kernel.*

Make sure Gentoo is matched up with your target kernel version

```
eselect kernel list
eselect kernel set #
```

Build it

```
zcat /proc/config.gz > /usr/src/linux
cd /usr/src/linux
make oldconfig
make modules_prepare
emerge --ask @module-rebuild
make
make modules_install
```

Install it

```
genkernel --no-menuconfig --no-clean --install all
```

Update bootloader

```
vim /boot/extlinux/extlinux.conf
```

Reboot and cross your fingers.

Clean-up/delete old files in `/boot` and corresponding bootloader entries.

#### Useful Links and References
1. [Gentoo Wiki: Kernel/Upgrade](https://wiki.gentoo.org/wiki/Kernel/Upgrade "Kernel/Upgrade")

