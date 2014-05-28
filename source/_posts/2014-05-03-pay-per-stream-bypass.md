---
title: 'pay-per-webcast?.. srsly?'
layout: post
date: 2014-05-03 07:56:55 -0700
comments: true
categories:
- Computing
---

{% img center /images/2014-05-03-pay-per-stream-bypass/scrot-2014-05-03-ffdevtools.png %}

*After 'inspecting' the source of a live webcast and the data that gets thrown around once the plugin is launched, I managed to get a 10$ webcast for free. To be honest, I feel like I just got lucky with this one.. While media is still woven into websites with embed tags as it was back when Geocities was booming, where besides the scrolling marquee we all insisted on looping our favorite song in the background, but this time theres all sorts of new protocols, plugins, and codecs at work. We can't just 'view-source' and expect to see 10-dollars-worth-of.mp4. There's nothing to worry about though, we only have to dig a little harder. Probably real hard if you're like me and have never had much experience with media plugins.. So lets get to it.*

First, you're going to want to check out the source of the page where the plugin and stream play. Your browser's developer tools come in real handy and should have everything you need for sleuthing around.

Right now we just need to take note of the `vendorID` and `mediaID` parameters. Both were mentioned at least a few times thoughout the page I was working with.

Next we want to examine the SMIL file which will tell us exactly where we can find our stream. I found mine by using Firefox's network console and paying attention to the back-and-forth dialog going on between the browser's plugin and the webcast host. I suspect if you did the same you'd come up with similar, so here's mine to save you the trouble.

```
curl hxxp:||cdn.m0b1ler1der.c0m/m0b1ler1der/mobilestorefront/<vendorID>/media/file/<mediaID>/streams.smil
```

In the output of the previous command here should be a couple key-value pairs like `content="http://yadayada.yup"` and `src="/theStreamsUWereLookinFor@rightHurr"` to help you put together a URI to pass to your chosen media player. 

This URI is direct access to the stream, but if it returns an error or otherwise you're going to need to invesigate further. My hope is that I've at least set you on the right foot toward success. As a final clue, here's what my result would've looked like using the example values I've used thus far.

```
http://yadayada.yup/i/theStreamsUWereLookinFor@rightHurr/master.m3u8
```

If you're wondering the origin of the parts of the URI not supplied explicitly in the SMIL, they were taken from a previous URI from the same site, before they started asking for money.
