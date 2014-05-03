---
title: 'pay-per-webcast?.. srsly?'
layout: post
date: 2014-05-03 07:56:55 -0700
comments: true
categories:
- Computing
---

{% img center /images/2014-05-03-pay-per-stream-bypass/scrot-2014-05-03-ffdevtools.png %}

*After studying the source of a live webcast and the data that gets thrown around once the plugin is triggered to play, I managed to get a 10$ webcast for free. Honestly, I havent taken the time to try and understand all the jquery and javascript behind html5 media plugins but it turns out you can figure out the URI to pass to `mplayer` (or similar) using the contents of the SMIL file pretty easily.*

First, you're going to want to check out the source where the stream is embedded. Take note of the `vendorID` and `mediaID` parameters.

Next we want to examine the SMIL file which holds will tell us exactly where we can find our stream.

```
curl hxxp:||cdn.m0b1ler1der.c0m/m0b1ler1der/mobilestorefront/<vendorID>/media/file/<mediaID>/streams.smil
```

There should be a `content="http://yadayadayada.yup"` as well as one or more `src="/theStreamsYouWereLookingFor@rightHurr"` key-value pairs to help you put together a URI to give a go using your chosen media player. If your target is anything like mine, you’ll have direct access to the stream, and saved yourself some money.

Here's my result to serve as an example or hint. More than likely it'll apply to all Mobilerider webcasts.

```
http://yadayadayada.yup/i/theStreamsYouWereLookingFor@rightHurr/master.m3u8
```

The parts of the string not supplied explicitly in the SMIL were taken from a previously valid URI from the same site.
