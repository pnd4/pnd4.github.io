---
author: pnd4
comments: true
date: 2013-03-24 19:56:36
layout: post
slug: improve-flash-drive-performance
title: Improve Flash Drive Performance
wordpress_id: 291
categories:
- Computing
---

So after having my 32 GB PNY Attache flash drive fail every time I tried to write to <pre>sync</pre>, it finally let me after using

{% codeblock %}
badblocks -vw /dev/sdx
{% endcodeblock %}


But discovering that command wasn't the end, I had to deal with it's almost impossible write-speed, this information helped:

Append to /etc/rc.local

{% codeblock %}
echo madvise > /sys/kernel/mm/transparent_hugepage/enabled
echo madvise > /sys/kernel/mm/transparent_hugepage/defrag
echo 0 > /sys/kernel/mm/transparent_hugepage/khugepaged/defrag
{% endcodeblock %}


Append to /etc/sysctl.conf

{% codeblock %}
kernel.shmmax=134217728
vm.dirty_background_bytes = 4194304
vm.dirty_bytes = 4194304
{% endcodeblock %}


Thanks once again to [ArchWiki](https://wiki.archlinux.org/index.php/USB_Storage_Devices#Poor_copy_performance_to_USB_pendrive)
