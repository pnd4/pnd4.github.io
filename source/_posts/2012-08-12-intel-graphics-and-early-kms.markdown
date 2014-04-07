---
author: pnd4
comments: true
date: 2012-08-12 17:28:59
layout: post
slug: intel-graphics-and-early-kms
title: Intel graphics and early-KMS
wordpress_id: 74
categories:
- Computing
---

{% img center /images/2012-08-12-intel-graphics-and-early-kms/intel-logo.jpg %}

_Since just about every laptop or netbook I've come into contact with has a Intel motherboard, I figured this topic should be covered to get the most out of your hardware, improve your overall experience, and simply enough, to do things right. I had to learn a little bit about KMS myself recently because sometimes things dont work out-of-the-box._

_You want to enable KMS because it allows the kernel to set the native resolution on the frame-buffer. The effects of this are fast TTY-switching, enhanced 3D performance, and in some cases power-saving features._

In order to enable KMS on the Intel mobile platform some changes possibly have to be made to your Kernel, X installation, bootloader, and startup configuration.

**Kernel **changes may only be necessary if you compiled your own (aka gentoo). In which case, simply enable the frame-buffer options:

{% codeblock %}
Device Drivers --->
  Graphics support --->
    Support for frame buffer devices --->
    (Disable all drivers, including VGA, Intel, nVidia, and ATI)

    (Further down, enable basic console support. KMS uses this.)
    Console display driver support --->
      <*>  Framebuffer Console Support

    /dev/agpgart (AGP Support) --->
      <*>  Intel 440LX/BX/GX, I8xx and E7x05 chipset support
      Direct Rendering Manager (XFree86 4.1.0 and higher DRI support) --->
      <*>  Intel 8xx/9xx/G3x/G4x/HD Graphics
      [*]    Enable modesetting on intel by default
{% endcodeblock %}

**Xorg **'s only requirement is that we install it and the proper xf86-video-intel driver package.

**Bootloader** changes are done so that our grub does not disable, use another driver, or try to set the resolution itself. Remember, we are letting the Kernel do this for us. so edit your /etc/default/grub and remove any of the following:



	
  * Any "nomodeset", "i915.modeset=0", "vga=" or "video=" at all present.

	
  * Anything that would enable another frame-buffer driver such as uvesafb.


**Start-up configuration** must reflect our efforts so that KMS is started early on in the process as possible to get the best effect. changes should be made to /etc/mkinitcpio.conf in Arch, or /etc/conf.d/modules in Gentoo to include the i915 module.

Finally regen your initial-ramdisk if you used one and your boot partition's GRUB config.

{% codeblock %}
## make initrd
# mkinitcpio -p linux
## generate a GRUB config
# grub-mkconfig -o /boot/grub/grub.cfg
{% endcodeblock %}


Reboot and [hopefully] reap the fruits of all your hard work.
