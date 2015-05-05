---
layout: post
title: "CLI Converting HD > SD"
date: 2014-05-31 22:37:32 -0700
comments: true
categories: 
- Computing
---

*After purchasing a paintball web-series I was a little disappointed to find my loot only available in 1080p. At about ~$4 an episode, you'd think they'd at least offer at least 1 other format, possibly for the old iPod Video's or in my case, an old netbook streaming media off my NAS via 802.11g.*

*In any case, doing the deed myself was surprising easy. Though I'd imagine someone without any prior knowledge of codecs, aspect ratio, and bitrate may run into trouble. I'd suggest they give my commands a shot.*

Lets start off by making sure we have `ffmpeg` installed on the buffest rig you've got. This can be preety heavy lifting and can take quite sometime on older machines.

Now assuming we have our original file `EP1_HD_1080p.mov` in our current directory, running the following command will get us going.

```
ffmpeg -i EP1_HD_1080p.mov -ac 2 -qscale 5 -f mp4 -s 854x480 ep1_sd_480p.mp4
```

To break it down, here's the same command with placeholders.

```
ffmpeg \
    -i [input-filename] \
    -ac [# of audio-channels] \
    -qscale [quality-scale: 1-31 (1 = highest quality)] \
    -f [format: mp4, avi, mkv, ..] \
    -s [Resolution: (Width)x(Height)] \
    [output-filename]
```

Now you may have checked out some examples before mine and noticed others' had a lot more options. It just goes to show that ffmpeg is the go-to utility. Whether small job like mine or the demands of a release-group like "YIFY", you can't go wrong.

As always, good luck!
