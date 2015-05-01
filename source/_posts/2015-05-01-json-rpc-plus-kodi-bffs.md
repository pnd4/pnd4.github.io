---
layout: post
title: "JSON-RPC + Kodi = BFFs"
date: 2015-05-01 05:52:21 -0700
comments: true
categories: Computing
---

#### The can of worms.

The other night I decided to do the long-overdue update of my Gentoo install on my netbook which serves as my XBMC machine. As expected, something along the way broke and XBMC's dependency, ffmpeg, failed to build. After a long struggle, I gave up on the XBMC ebuild and went with XBMC's successor, Kodi. Making haste, I neglected to enable any of Kodi's optional USE-flags. The result: everything perfect Kodi-side (faster actually), but my various remote-control browser-addons, mobile apps, and scripts were made useless.

#### Meet Kodi's fwiend, JSON-RPC

For months now I've been using a script called `xbmc-play`. It was simple to use, and lightweight. Problem is that, like most XBMC/Kodi remotes, the underlying mechanics that handle the communication required the webserver feature on the Kodi machine. Since I know a fair amount about scripting and very little of building extensions for browsers and Android apps, scripting became the first part of this journey to regain remoting ability.

In first discovering the lack of a webserver, running `netstat -tuanp` confirmed no process was listening on the defaut port 8080. The listing did reveal that after enabling "Allow programs on other systems to control Kodi" it listens on port 9090. And a quick google of Kodi's relation to this port will tell you that the JSON-RPC protocol is what's understood on Kodi's end.

#### First Impression

Looking over the JSON-RPC API articles at [the Kodi Wiki](http://kodi.wiki/view/JSON-RPC_API) and it's [official documentation](http://www.jsonrpc.org/specification) for ideas about the syntax of these 'requests' the script had to make.

Prior experience manually interacting over TCP/IP came in handy, and I was quickly able to test some proto-type requests with Kodi using the suggested `telnet` tool. Ultimately, I chose to work with `netcat` as it seemed more fitting for use in the resulting script that follows:

{% include_code lang:sh kodi-play.sh %}

#### What's Next

Having got to dabble into communicating with Kodi over JSON-RPC and being met less trouble than success. I'm thinking about pursuing a desktop application or at least framework for controlling Kodi/XBMC. It would certainly fulfull my need, and maybe help someone else looking for remote-control without the need for a excess bloat services like a webserver or unnecessary consumption of resources client-side from yet another browser-addon.

But like all of these projects I pursue on the side, it's future is uncertain.
