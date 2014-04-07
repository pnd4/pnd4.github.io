---
author: pnd4
comments: true
date: 2012-11-30 18:49:09
layout: post
slug: encrypted-arch-luks-on-lvm
title: 'Arch Install: Encrypted (LUKS on LVM)'
wordpress_id: 182
categories:
- Computing
---

{% img center /images/2012-11-30-encrypted-arch-luks-on-lvm/arch94e.jpg %}


> "I remember new years eve 2010/11, crystal clear night, awesome fireworks in Zurich Switzerland, drinking with my bro and then he said "you have no soul do you?" -- **nohitall**


_Alright, so it's been awhile since I made an entry, 'boo-hoo'.. But I bring treats: Notes I took while replacing Gentoo with Arch on my desktop. Yeah, since I finally got my monitors in, I figured it would be a lot of wasted time compiling in Gentoo when I could be doing hood-rat stuff instead on Arch.. Well anyway I figured I'd kick things up a notch, having watched Inception recently. Using this install you get 3 things: block-disk-encryption (LUKS) on top of logical-volume-management (LVM2), and finally your OS (Arch) all warm up inside all of that.. Now you may ask yourself: "why did he use LVM when he seems to be using a pretty simple partition scheme?__", and the answer is: "Because, pnd4 can." .. Yeah-see, I took that one out of nohitall's evil book of nerd things to do when you're lacking sleep and bored. Come say 'Hi' on #crunchbang (via Freenode); Im serving up 'Das Boot' to anyone who wants to complain about how pointless this block of text is.. enjoi!_

Start by booting the installation media

Use fdisk to create 2 partitions

  * the boot partition can be pretty small at around 100MiB or so.

Write random data to drive

{% codeblock %}
# cryptsetup -d /dev/random -c aes-xts-plain -s 512 create lvmname /dev/<device>
# dd if=/dev/urandom of=/dev/mapper/lvmname
{% endcodeblock %}

Optional: In another terminal run a command to monitor progress

{% codeblock %}
# watch -n 10 killall -USR1 dd
{% endcodeblock %}

Remove volume of scrambled data.

{% codeblock %}
# cryptsetup remove lvmname
{% endcodeblock %}

Set up LVM logical volumes: root, swap, var, tmp, home

{% codeblock %}
# lvm pvcreate /dev/<device>
# lvm vgcreate lvmname /dev/<device>
# lvm lvcreate -L 12G -n rootname lvmname
# lvm lvcreate -L 4G -n swapname lvmname
# lvm lvcreate -L 8G -n varname lvmname
# lvm lvcreate -L 1G -n tmpname lvmname
# lvm lvcreate -l 100%FREE -n homename lvmname
{% endcodeblock %}

Encrypt root

{% codeblock %}
# cryptsetup luksFormat -c aes-xts-plain -s 512 /dev/lvmname/rootname
# cryptsetup luksOpen /dev/lvmname/rootname root
{% endcodeblock %}

Set up root with chosen filesystem [for example; ext4]

{% codeblock %}
# mkfs.ext4 /dev/mapper/root -L root
# mount /dev/mapper/root /mnt
{% endcodeblock %}

Set up boot with chosen filesystem [for example; ext2]

{% codeblock %}
# dd if=/dev/zero of=/dev/sda1 bs=1M
# mkfs.ext2 /dev/sda1 -L boot
# mkdir /mnt/boot
# mount /dev/sda1 /mnt/boot
{% endcodeblock %}

Create key for home and var store in /etc/luks-keys/home

{% codeblock %}
# mkdir -p -m 700 /mnt/etc/luks-keys
# dd if=/dev/random of=/mnt/etc/luks-keys/home bs=1 count=256
# dd if=/dev/random of=/mnt/etc/luks-keys/var bs=1 count=256
{% endcodeblock %}

Encrypt, format, and mount var

{% codeblock %}
# cryptsetup luksFormat -c aes-xts-plain -s 512 /dev/lvmname/varname /mnt/etc/luks-keys/var
# cryptsetup luksOpen /dev/lvmname/varname var
# mkfs.ext4 /dev/mapper/var -L var
# mkdir /mnt/var
# mount /dev/mapper/var /mnt/var
{% endcodeblock %}

Encrypt, format, and mount home

{% codeblock %}
# cryptsetup luksFormat -c aes-xts-plain -s 512 /dev/lvmname/varname /mnt/etc/luks-keys/home
# cryptsetup luksOpen /dev/lvmname/homename home
# mkfs.ext4 /dev/mapper/home -L home
# mkdir /mnt/home
# mount /dev/mapper/home /mnt/home
{% endcodeblock %}

Connect to internet

#### Install arch via 'pacstrap'

  * Syslinux or GRUB, whatever floats your boat.

  * Wicd optional but great if planning to use Wi-Fi

{% codeblock %}
# pacstrap /mnt base base-devel syslinux wicd
{% endcodeblock %}

Generate new fstab

{% codeblock %}
# genfstab -p /mnt >> /mnt/etc/fstab
{% endcodeblock %}

Chroot into new install

{% codeblock %}
# arch-chroot /mnt
{% endcodeblock %}

Set hostname

{% codeblock %}
# echo "h0stname" >> /etc/hostname
{% endcodeblock %}

Set timezone

{% codeblock %}
# ln -s /usr/share/zoneinfo/America/Los_Angeles /etc/localtime
{% endcodeblock %}

Edit /etc/locale.gen

{% codeblock %}
# locale-gen
{% endcodeblock %}

Configure /etc/locale.conf

{% codeblock %}
LANG="en_US.UTF-8"
LC_COLLATE="C"
LC_TIME="en_US.UTF-8"
{% endcodeblock %}

#### Edit /etc/mkinitcpio.conf and generate initrd

  * Put lvm2 and encrypt (in this order) before filesystems in HOOKS

{% codeblock %}
# mkinitcpio -p linux
{% endcodeblock %}

Change APPEND line in /boot/syslinux/syslinux.cfg

{% codeblock %}
APPEND cryptdevice=/dev/mapper/lvmname-root:root root=/dev/mapper/root ro
{% endcodeblock %}

Commit changes to /boot

  *  -i = Puts file

  * -a = Set boot flag

  * -m = Install MBR boot code

{% codeblock %}
# syslinux-install_update -i -a -m
{% endcodeblock %}

Add to /etc/fstab

{% codeblock %}
/dev/mapper/tmp  /tmp      tmpfs   defaults            0 0
/dev/mapper/swap none      swap    sw                  0 0
tmpfs            /dev/shm  tmpfs   nodev,nosuid,noexec 0 0
{% endcodeblock %}

Edit /etc/crypttab

{% codeblock %}
var   /dev/lvmname/varname  /etc/luks-keys/var
home  /dev/lvmname/homename /etc/luks-keys/home
swap  /dev/lvmname/swap     /dev/urandom  swap,cipher:aes-cbc-essiv:sha256,size=256
tmp   /dev/lvmname/tmp      /dev/urandom  tmp,cipher:aes-cbc-essiv:sha256,size=256
{% endcodeblock %}

Set root password

{% codeblock %}
# passwd
{% endcodeblock %}

Reboot

{% codeblock %}
# reboot
{% endcodeblock %}

[Fin]
