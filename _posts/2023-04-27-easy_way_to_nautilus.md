---
layout: post
title: Launching your file manager from the command line avoiding the rubbish!
category: linux
draft: true
published: true
comments: true
---

After spending years using weird magic spells to launch a graphical file manager (e.g. [nautilus](https://wiki.gnome.org/action/show/Apps/Files)) from the command line without it printing a lot of rubbish, I finally [learned](https://askubuntu.com/a/1089298) that [xdg-open](https://linux.die.net/man/1/xdg-open) **just works**! 

Use `xdg-open .` and you will have your graphical file manager PLUS a clean terminal!