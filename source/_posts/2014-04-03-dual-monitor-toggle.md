---
layout: post
title: "Dual-Monitor Toggle"
date: 2014-04-03 02:07
comments: true
categories: 
---

_Recently I found myself in need of a way to switch X into single-monitor mode without having to kill the running instance of X, which is fine if you don't have any unsaved work, since it crashes all programs running within X as well._


## xrandr

Using `xrandr`[^1] we are able to dynamically modify our desktop's properties.

**OFF**

```
xrandr --output DVI-0 --off
```

**ON**

```
xrandr --output DVI-0 --left-of VGA-0 --auto
```

[^1]: [Xrandr's Man Page](http://www.x.org/archive/X11R7.5/doc/man/man1/xrandr.1.html)
