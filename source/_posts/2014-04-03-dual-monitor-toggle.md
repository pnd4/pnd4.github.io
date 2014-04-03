---
layout: post
title: "Dual-Monitor Toggle"
date: 2014-04-03 02:07
comments: true
categories: 
---

Recently I found myself in need of a way to switch X into single-monitor mode without having to kill the running instance of X, which is fine if you don't have any unsaved work, since it crashes all programs running within X as well.

Currently, I've configured X to use a single video card's DVI and VGA outputs to use the two monitors as one large desktop.

## xrandr

Using this command we are able to dynamically modify our desktop's properties. My examples toggle my left monitor 'DVI-0', but the syntax is easy to understand and adapt for just about any configuration.

*OFF*
> xrandr --output DVI-0 --off

*ON*
> xrandr --output DVI-0 --left-of VGA-0 --auto

Other Resources
[xrandr manual](http://www.x.org/archive/X11R7.5/doc/man/man1/xrandr.1.html)
