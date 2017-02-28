---
layout: post
title: Mounting an external USB device formatted with exFAT on Linux Ubuntu
category: linux
draft: false
published: true
comments: true
---

This post is a personal reminder. I'm always forgetting Ubuntu (up to 16.04), doesn't know how to mount [exFAT - Extended File Allocation Table](https://en.wikipedia.org/wiki/ExFAT) and then I need to [Google for it](http://unixnme.blogspot.co.uk/2016/04/how-to-mount-exfat-partition-in-ubuntu.html). Why would you need exFAT? Among other things, it's possible to have files bigger than 4GB.

Ok, by default Ubuntu doesn't know how to deal with exFAT and we need to install the [FUSE](https://en.wikipedia.org/wiki/Filesystem_in_Userspace) module [exfat-fuse](https://github.com/relan/exfat):

```
$ sudo apt-get install exfat-fuse exfat-utils
```

That's it. Ubuntu will mount it automatically for you, somewhere inside `/media` and using `your_user_name/your_media_name`.

Cheers!
