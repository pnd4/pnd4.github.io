---
author: pnd4
comments: true
date: 2012-08-10 01:42:08
layout: post
slug: installing-bt5-chroot-on-the-sprint-htc-evo-4g-non-lte
title: Installing BT5 (chroot) on the Sprint HTC Evo 4G (non LTE)
wordpress_id: 36
categories:
- Computing
---

{% img center /images/2012-08-10-installing-bt5-chroot-on-the-sprint-htc-evo-4g-non-lte/backtrack-logo1.jpg %}

Tonight ParkerR and I decided to get some pentesting tools into our devices. He has a Nexus 7 and I.. well I have my phone. Anyway, after a frustrating time working with p7zip which was used in the particular mirror we chose, we finally got it extracted. So grab your files [HERE](http://forum.xda-developers.com/showthread.php?t=1079898) and follow along,

{% codeblock %}
$ 7z e downloaded-file.7z.001
{% endcodeblock %}


Next we had to copy over the files to the SD-card as per the instructions. Since my uSD (MicroSD) port on my phone is uber-janky I just turned off my phone and pulled out the uSD card instead of using ADB and opt'd for the slot in my trusty laptop. I was then able to mount the removable storage and [ever so slowly and unreliably] copy over the extracted contents into the SD's bt5 folder like so:

{% codeblock %}
mount -t vfat /dev/mmcblk0p1 /mnt/sdcard -o rw
mkdir /mnt/sdcard/bt5
# because copy was not working too well for me.. we dd.
dd if=/home/user/bt5/bt5.img of=/mnt/sdcard/bt5/bt5.img
# answer no to the clobber
cp -i /home/user/bt5/* /mnt/sdcard/bt5/ 
# cd && umount /mnt/sdcard
{% endcodeblock %}

Having unmounted the sdcard in this last line, we can now remove the card and toss that back into our phone and boot up our Android phone as usual.

Fire up the Terminal emulator and run the 'bt' script included as a super-user.. or if you have SSHDroid installed, we can SSH into our phone as root and run the script to start up the chroot'd environment.

{% codeblock %}
$ ssh 192.168.1.<android> -l root
(android)# sh /sdcard/bt5/bt
{% endcodeblock %}

Hopefully that starts up your Backtrack 5 chrooted environment. If you used Terminal Emulator you're good to walk down the street and still use the command line to your heart's desire. Unfortunately for SSH, soon as you lose your LAN connection, the session will drop out. So be sure to consider that before embarking out on your mission.

