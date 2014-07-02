---
layout: post
title: "Creating a PKGBUILD for lzo-2.08 on ArchLinuxARM"
date: 2014-07-02 06:41:41 -0700
comments: true
categories:
- Computing
---

*Using ArchLinuxARM with OpenVPN broke on my PogoPlug e02 after lzo2 was updated from 2.06-3 to 2.07-2 a few days ago. After another ALARM user confirmed the issue, a couple days passed without a solution and downgrading to 2.06-3 not only is bad practice due to "CVE-2014-4607" but paper-thin, since its disappearing from repos and its likely it won't be in your local package cache forever.. Fueled by boredom, I decided to fix the problem myself.*

#### Using 2.07-2 as a base

Copied PKGBUILD for lzo2-2.07-2 from ABS.
Changed 'arch' to suit ALARM.
Deleted the stuff regarding 2.07 (patch: src, checksums).
Changed pkg version and release values from '2.07-2' to make '2.08-1' respectively.

#### Making it work

Seems like adding `CFLAGS="-DLZO_DEBUG"` before `./configure ..` made the difference whether it built or not.

#### Maintaining Security?

However setting the CFLAGS environment variable showed a warning that if not using at least "-O" ("-O2" being the default makepkg.conf optimization CFLAG) then it would not use "-D_FORTIFY_SOURCE=2" which sounds important from a security-minded perspective.

After some light reading about GCC's flags:

* [Security Related Flags](http://www.outflux.net/blog/archives/2014/01/27/fstack-protector-strong/)
* [-O option flag](http://www.rapidtables.com/code/linux/gcc/gcc-o.htm#optimization)
* [Relationship: FORTIFY_SOURCE & O-Flag](http://gentoo.2317880.n4.nabble.com/Should-we-disable-FORTIFY-SOURCE-for-packages-where-it-is-not-default-td138737.html)

Looks like the best option would be to disable '_FORTIFY_SOURCE' but still maintain the highest level of security otherwise and retain the ability to protect from stack-smashing attacks by setting 'stack-protector-all'. It seems with 2.08 we have only two choices: "-O0" or no optimizations at all. Personally, I'd gladly sacrifice runtime-speed optimizations for security, when having both is not an option and since ARM devices don't have much memory, why not use "-O0" if we can.

This equates to `CFLAGS="-Wall -O0 -U_FORTIFY_SOURCE -fstack-protector-all"`  
(seen on line #18)

#### Full PKGBUILD

{% include_code lang:sh lzo-2.08-1-arm/PKGBUILD %}

#### TO-DO
* Have someone proof/verify the PKGBUILD.
