---
layout: post
title: How to use VSCode remotely to edit files on your Raspberry Pi
category: linux
draft: true
published: true
comments: true
date: 2021-05-08 00:00:00
---

This is yet another *very-short-post&trade;*. I really like VSCode because I think it speeds up lots of things. However, when I'm developing stuff on the Raspberry Pi, I'm often forced to keep moving files back & forth or just use vim. So, today I decided to google a little bit and I found a simple solution: [sshfs](https://github.com/libfuse/sshfs)

<!--more-->

Install it (Debian-based Linux):

```$ sudo apt-get install sshfs```

You don't even need to be root. In my situation, I created a dir under home called "sshfs" and from inside that dir (rpi0edgetpu.local is the avahi name of my RPI0, I could have just put the IP):

```$ sshfs pi@rpi0edgetpu.local:/home/ rpi0/```

Now, you just need to call vscode from the sshfs dir and you are good to go:

```$ code .```

After you are done with your work, umount sshfs drive:

```$ umount rpi0```

I noticed VSCode wasn't happy when I called it from the rpi0 dir I got this message:  

```cannot open path of the current working directory: Permission denied```

Apparently, this was a problem related to [snap](https://bugs.launchpad.net/snappy/+bug/1620771) since [my VSCode was installed via snap](https://snapcraft.io/code).