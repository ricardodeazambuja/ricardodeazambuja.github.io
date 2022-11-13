---
layout: post
title: Old digital microscope was driving Ubuntu nuts!
category: linux
draft: true
published: true
comments: true
date: 2022-11-13 00:00:00
---

Today I needed to check some connections in the PCB of my ST-Link V2 clone because I wanted to add the trace support following the [nice explanations from here](https://lujji.github.io/blog/stlink-clone-trace/). However, my old brandless digital microscope (you know, they all look the same and come in a blue box...) refused to work. [dmesg](https://man7.org/linux/man-pages/man1/dmesg.1.html) helped me find some repeated error messages (`Failed to query (GET_DEF) UVC control 4 on unit 1` or `Failed to query (GET_MIN) UVC control 4 on unit 1`) and a little bit of [google-fu](https://en.wiktionary.org/wiki/Google-fu) did the rest. I found my system was suffering from a problem with [`libwebcam`](https://packages.debian.org/sid/libwebcam0) and [uvcdynctrl](https://manpages.ubuntu.com/manpages/xenial/man1/uvcdynctrl.1.html) and the log file `/var/log/uvcdynctrl-udev.log` was already at 68GB (?!?).

I learned [this is a super old bug (first message is from 2011!)](https://bugs.launchpad.net/ubuntu/+source/libwebcam/+bug/811604) and it can slow down your system to a halt.  Using `apt show` and the very useful [`apt-rdepends`](https://manpages.ubuntu.com/manpages/bionic/man1/apt-rdepends.1.html) I noticed `libwebcam0` and `uvcdynctrl` just depended on each other... so following the suggestion and removing `libwebcam0`, `uvcdynctrl` and `uvcdynctrl-data` solved my problem (`sudo apt remove libwebcam0 uvcdynctrl uvcdynctrl-data`).

I hope this blog post can help other people avoid spending time on google to solve the same 11-year-old problem...