---
layout: post
title: Gentoo - Genkernel Upgrade Steps
---
I use genkernel to install my kernel.. this isn't the best way to do things but for now it gets the job done. Gentoo isn't my primary distro so I sometimes forget the steps to go through when they push a new kernel.

### TL;DR/Commands
After using 'eselect kernel [list|set #]' to switch to the latest version
{% highlight bash %}
    zcat /proc/config.gz > /usr/src/linux
    cd /usr/src/linux
    make oldconfig
    make modules_prepare
    emerge --ask @module-rebuild
    make
    # Now sit and wait til your childen get old and put you in a retirement home.
    make modules_install
    genkernel --no-menuconfig --no-clean --install all
    # Update your bootloader's config
    # Reboot and cross your fingers

    # Clean-up/delete old files from /boot
    # Clean-up old bootloader entries 
{% endhighlight %}

#### Useful Links and References
1. [Gentoo Wiki: Kernel/Upgrade](https://wiki.gentoo.org/wiki/Kernel/Upgrade "Kernel/Upgrade")

