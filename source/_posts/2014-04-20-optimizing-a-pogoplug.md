---
layout: post
title: "Optimizing a Pogoplug"
date: 2014-04-20 04:46
comments: true
categories: 
- Computing
- Pogoplug
---

** Here's a few tips on how to maximize your performance when using an embedded device like Pogoplug, RaspberryPi, etc. **

#### Flash-Drive I/O

Flash memory is cheap and small. Most even have enough storage space that you can house your `ROOTFS` pretty comfortably. The downside is pretty sluggish reads/writes. Fortunately the pogoplug has 256MB's of RAM; By allocating some commonly written directories in RAM we gain speed plus the benefit of less write-cycles overall to our flash-memory. If you don't already know, flash memory has a limited number of writes, so this effectively prolongs the life of your drive/system.

Simply add/replace the appropriate lines to `fstab` ..

```
tmpfs /tmp         tmpfs nodev,nosuid,noatime           0 0
tmpfs /var/tmp     tmpfs nodev,nosuid,noatime           0 0
tmpfs /var/log     tmpfs nodev,nosuid,noatime,size=20M  0 0
tmpfs /var/run     tmpfs defaults,noatime,size=1M       0 0
tmpfs /var/lock    tmpfs defaults,noatime,size=1M       0 0
```

#### I/O Governor

The logic that is behind your drive/disk access can be tweaked reducing lag by appending the following line to `/etc/rc.local` 

``` 
echo deadline > /sys/block/sda/queue/scheduler
```

Note That I don’t use the `noop` scheduler because `deadline` can be better as it group small accesses, which improve latency. The default, `cfq` is better suited for disk-drives.
