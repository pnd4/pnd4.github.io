---
author: pnd4
comments: true
date: 2013-02-10 21:49:54
layout: post
published: false
slug: archlinuxarm-x-pogoplug-e02
title: ArchLinuxARM x Pogoplug-E02
wordpress_id: 251
categories:
- Computing
---

_Just a long rant about an ongoing project that failed.. hoping for a little cognitive therapy._

So the $16.99 Pogoplug I bought about a month ago isn't working out to be such a breeze setting up. I originally was planning to use this as a low-powered *nix box to deploy Intrusion Detection and host OpenVPN on my home network, but several factors have impeded my master plan:

Right off the bat, my Pogoplug accepted the modified bootloader u-Boot which gave me a false sense of comfort in modding this device. The trouble began during the second phase of installing the OS where you put the rootfs on a medium such as USB-flashdrive for uBoot to boot. It turns out the only thumbdrive I own is not great at being detected before uBoot decides to give up.

The next place I had difficulty is where you actually have the console broadcast over the network interactively for debugging.. This is my first experience with net-console, but my first experience dealing with uBoot's prompt which turns out isn't like GRUB or Syslinux at all. Somehow enabling this left my Pogoplug in a state where it could no longer boot to the "Pogoplug>" prompt and instead only be accessible through NetCat like it intended.. My mistake here was not undo-ing my changes and getting my ass back to the safety of "Pogoplug>"

Digging through the plethora of resources about soft-modding the Pogoplug and learning a great deal about embedded-Linux along the way, I finally found my Pogoplug worse off than when I had originally abandoned it (after the Flash-drive difficulty).. Last night I begun trying to restore the default Pogoplug OS by flashing its MTD partitions with what I thought were default Nanddumps. After the console became unresponsive the device itself no longer shows up on the network, or has its LED indicate any activity. Seems that the rabbit-hole that is Archlinux-ARM, while vast, is also riddled with old, and as it turns out, conflicting advice..

Now I wait for my USB-to-Serial adapter to arrive so I can hack together a Serial-TTL interface to possibly revive the Pogoplug and further waste more time than the project is probably worth. I keep trying to promise myself it'll end in success but the outlook is kinda bleak at this point.. Definitely not going to rush into Nandwrite's this time around and sure as hell gonna try and stop being so impatient when it comes to advancing along these little projects I get myself into.
