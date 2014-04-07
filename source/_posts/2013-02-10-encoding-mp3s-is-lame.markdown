---
author: pnd4
comments: true
date: 2013-02-10 23:19:22
layout: post
slug: encoding-mp3s-is-lame
title: Encoding MP3's is LAME
wordpress_id: 257
categories:
- Computing
---

{% img center /images/2013-02-10-encoding-mp3s-is-lame/Screenshot-02102013-030954-PM-1024x592.png %}

Once in a great while I come across artists and uploaders who still distribute tracks as .wav .. This is great if you wanna do some editing and what-not, but I'd rather turn a 70MB into 9MB for the sake of space. Here's a quick one-liner as an example

{% codeblock %}
lame original-file.wav -h -V0 --vbr-new
{% endcodeblock %}


This results in original-file.mp3 , a high-quality 320 kbps VBR MP3.

Wasn't that much easier than opening some GUI-intensive bloatware in Windows?.. Just one of the many reasons why *Nix is awesome.
