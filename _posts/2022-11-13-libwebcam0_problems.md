---
layout: post
title: Old digital microscope was driving Ubuntu nuts!
category: linux
draft: true
published: true
comments: true
date: 2022-11-13 00:00:00
---

Today I needed to check some connections in the PCB of my ST-Link V2 clone because I wanted to add the trace support following the [nice explanations from here](https://lujji.github.io/blog/stlink-clone-trace/). However, my old brandless digital microscope (you know, they all look the same and come in a blue box...) refused to work. [dmesg](https://man7.org/linux/man-pages/man1/dmesg.1.html) helped me find some repeated error messages (`Failed to query (GET_DEF) UVC control 4 on unit 1` or `Failed to query (GET_MIN) UVC control 4 on unit 1`) and a little bit of [google-fu](https://en.wiktionary.org/wiki/Google-fu) did the rest. I found my system was suffering from a problem with [`libwebcam0`](https://packages.debian.org/sid/libwebcam0) and [`uvcdynctrl`](https://manpages.ubuntu.com/manpages/xenial/man1/uvcdynctrl.1.html) and the log file `/var/log/uvcdynctrl-udev.log` was already at 68GB (?!?).

I learned [this is a super old bug (first message is from 2011!)](https://bugs.launchpad.net/ubuntu/+source/libwebcam/+bug/811604) and it can slow down your system to a halt.  Using `apt show` and the very useful [`apt-rdepends`](https://manpages.ubuntu.com/manpages/bionic/man1/apt-rdepends.1.html) I noticed `libwebcam0` and `uvcdynctrl` just depended on each other... so following the suggestion and removing `libwebcam0`, `uvcdynctrl` and `uvcdynctrl-data` solved my problem (`sudo apt remove libwebcam0 uvcdynctrl uvcdynctrl-data`).

I hope this blog post can help other people avoid spending time on google to solve the same 11-year-old problem...


**UPDATE (29/01/2023):**     
[Ubuntu Cheese](https://manpages.ubuntu.com/manpages/xenial/man1/cheese.1.html) sometimes is too picky and stops the stream with an error message, so I suggest using [ffplay](https://ffmpeg.org/ffplay.html). First, connect your microscope (webcam) and check the devices available (`v4l2-ctl --list-devices`):
```
USB2.0 UVC PC Camera: USB2.0 UV (usb-0000:00:14.0-2):
	/dev/video2
	/dev/video3

Integrated_Webcam_HD: Integrate (usb-0000:00:14.0-5):
	/dev/video0
	/dev/video1
```

In my situation, the microscope was the `USB2.0 UVC PC Camera`. You can get extra info with `ffmpeg -f v4l2 -list_formats all -i /dev/video2`. Finally, just use `ffplay /dev/video2`.

**Affiliated links**

If you want to support my work, you can buy an equivalent USB microscope on Amazon (or anything else, really) using the affiliated link below:

* [USB Microscope Camera](https://amzn.to/44bhHCH)

You lose nothing and I (may) get a few peanuts from Amazon.