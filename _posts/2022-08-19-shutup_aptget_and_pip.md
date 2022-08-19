---
layout: post
title: Finally I found how to fully shut up apt-get!
category: linux
draft: true
published: true
comments: true
date: 2022-08-19 00:00:00
---

I am always using [Google Colab](https://colab.research.google.com/), but in many cases I also need to install something using [`apt-get`](https://linux.die.net/man/8/apt-get). The problem was that sometimes you need to add a new repository, update, install... then your notebook becomes full of text and that eats your memory (locally too as the browser needs to render that after all). So, today I found [a nice post](https://peteris.rocks/blog/quiet-and-unattended-installation-with-apt-get/) explaining the reason why the `-qq` argument may still leave some bits of text behind. You should go there and read it by yourself, but I will copy some info here in case that website disappears.

To add a new repository:
```
sudo apt-add-repository ppa:some-repository-here -y > /dev/null
```

And the ultimate commands:
```
sudo DEBIAN_FRONTEND=noninteractive apt-get update -qq < /dev/null > /dev/null
```

and

```
sudo DEBIAN_FRONTEND=noninteractive apt-get install some_cool_free_software -qq < /dev/null > /dev/null
```

As I started this post mentioning Google Colab, I think it's worth pasting here the recipe to shut up [`pip`](https://pypi.org/project/pip/) as well:

```
pip -q install --upgrade some_cool_python_package > /dev/null
```