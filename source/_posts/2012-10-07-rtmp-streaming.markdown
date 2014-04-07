---
author: pnd4
comments: true
date: 2012-10-07 16:48:06
layout: post
slug: rtmp-streaming
title: RTMP streaming
wordpress_id: 169
categories:
- Computing
---




[![screenshot-100712-174012.png](/images/2012-10-07-rtmp-streaming/screenshot-100712-174012.png)](/images/2012-10-07-rtmp-streaming/screenshot-100712-174012.png)







Human beings must have action; they will make it if they cannot find it.




**_-- Albert Einstein_**









# Requirements



	
  * video player that supports rtmp streaming [ex: vlc, mplayer]

	
  * rtmpdump


# Syntax

{% codeblock %}
rtmpdump -v -r [rtmp://stream] -W "[webBasedApplet] -v | [localMediaPlayer] -
{% endcodeblock %}



# Example 1

{% codeblock %}
rtmpdump -v -r rtmp://188.122.86.236:1935/live/_definst_/kdjfkdfksjkfs1 -W http://cdn.yycast.com/player/player.swf -p http://www.limev.com/ | mplayer -
{% endcodeblock %}

