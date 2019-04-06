---
layout: post
title: Loading code directly from git (or anywhere actually) inside a Jupyter cell
category: jupyter
draft: true
published: true
comments: true
---

I may be getting used to short posts, but here it comes: this will be another zippy one! The other day, I realized something quite interesting about the Jupyter notebook (in fact, it comes from IPython...) magic ```%load```. You can use it with an URL! Sadly, it still doesn't work with Google Colab, but it works with your local Jupyter like a charm. Also, the use of ```%load``` is safe'*ish* considering it will only **load** the code **without executing it** unless you execute the cell again.

If you want to import from GitHub you need to use the link to the ```raw``` file or it will load the source code of the html page. Here I give two examples based on a [gist I created](https://gist.github.com/ricardodeazambuja/4d789eb2933c0931bdb93cb8bb438b1c):
1. If you type this ```%load https://gist.github.com/ricardodeazambuja/4d789eb2933c0931bdb93cb8bb438b1c``` it will load the html source code of the page.
2. Now, if you use the raw link ```%load https://gist.githubusercontent.com/ricardodeazambuja/4d789eb2933c0931bdb93cb8bb438b1c/raw/11204f711559d5ba0fe8fd51636483afe0633cf7/test_jupyter_load.py``` it will work as expected, but this link is way too long.

One easy solution for the *ultra-long-ugly-link* problem is the [GitHub URL shortener](https://git.io/). I used it with the raw link and now you just need this to load the code directly into a cell: ```%load https://git.io/fjL5H```.

Again, some people may say it's not safe to use URL shorteners, but if you are the person that created the link using the GitHub URL shortener and considering the load magic doesn't execute the code (it only loads) it is **kind of safe**. Probably, someone will find a way to mess up with other people's notebooks because Jupyter uses HTML/Javascript, but this is also true to anything else you get from the web unless you are a security expert and check line-by-line any library/code you reuse.


Ok, this was supposed to be a zippy post, so [*cheerio*](https://en.wiktionary.org/wiki/cheerio)!