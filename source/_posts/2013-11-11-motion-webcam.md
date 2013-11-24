---
layout: post
title: Motion Webcam
---

###Webcam Prices
11.11.2013
- 20-23 HD-3000 
- 15-20 Rocketfish 720p RF-HDWEB
- 17 M$ HD-2300

###[RasPi Notes](http://forum.micasaverde.com/index.php?topic=9104.15)
RasPi community has good info on the subject. Should be valid for Pogoplugs too.

> My Raspberry Pi was ordered just over a month ago and supposedly I'll have it in another two months. A friend of mine ordered one two weeks ago and he already has his.  ???
>
>In the interim I wanted to chip in with some experiences I have using USB webcams with Vera. I attached mine to Pogoplugs running Archlinux ARM. That distro is available for the Raspberry Pi and I've been very happy with it on my Pogoplugs. You should be able to support streaming quite a few webcams on your Raspberry Pi, I have as many as four hanging off my Pogoplugs.
>
>A few recommendations I have for streaming USB webcams with linux:
>
>1. Unless you need the capabilities of motion (that is, you are using the motion detection built in to motion) use mjpg_streamer instead of motion. Motion processes each image to see if pixels have changed, and by default runs a lot of binary morphology on the images (erode, dilate, etc), where mjpg_streamer just streams. On my Pogoplus with four cameras this means the difference between 60%+ cpu utilization versus single digits (and to get down to 60% I had to drop the framerate to 2Hz and go through a bunch of options to turn off as much processing as possible). I have another machine running zoneminder which processes my streams which is why I don't mind forgoing motion detection.
>
>2. Use MJPEG instead of YUV
>If you want multiple webcams on a single USB bus this is basically a necessity. Even if you don't it means a lot less data to process. This is the default in mjpg_streamer, in motion set: "v4l2_palette 2" in motion.conf
>
>3. Get a webcam with known support
>Some webcams have a problem where the request a lot more bandwidth than they need and this means you can't use two at the same time. There is a hack to get around this in YUV mode, but not MJPEG which isn't much of a help. If you are up for hacking the driver yourself it should be possible to skip the BW check and make these work anyway, but that is quite a bit of work.
>
>Cameras that work simultaneously (no bandwidth bug):
>-Logitech C120
>-Logitech C160
>-Logitech B500
>-Logitech Quickcam E 3500
>-Logitech Quickcam Messenger
>-Microsoft HD-3000
>-Microsoft HD-5000
>-Rocketfish HD Webcam Pro
>
>Cameras that do not work in multiples (bandwidth bug?):
-Logitech C110
-Logitech C310
-Creative Live! Cam Video IM Ultra
-HP 2-Megapixel Webcam (RZ406AA)
>
> My current recommendation is probably the HD-3000. It is 720p and can be found for about $20. It does NOT have autofocus which I think is good for a webcam you leave running 24/7. I tried the HD-5000 and it spends a lot of time refocusing. I'm afraid it would break after a few weeks. The C160 is currently the cheapest, about $8 shipped on ebay. Meritline sometimes sells it for $6. The irritating thing about the c120/c160 is that they have a focusing ring you have to adjust. For a security camera I would prefer fixed focus. I buy any webcam I can get at a firesale so I'll keep trying more - I would appreciate results from anyone else as well.
>
>EDIT: Added a few more cameras]
>
>It turns out you can disable autofocus on UVC supported webcams like this:
>
>v4l2-ctl --verbose --set-ctrl=focus_auto=0
>
>At least it works for me on all the AF cameras I have to test (Microsoft & Rocketfish).
>
>Not only is this a good idea for camera longevity (I would think so at least) it helps prevents false motion alarms.

#### Useful Links and References
1. [eLinux: RasPi Webcam compatibility list](http://elinux.org/RPi_USB_Webcams)

