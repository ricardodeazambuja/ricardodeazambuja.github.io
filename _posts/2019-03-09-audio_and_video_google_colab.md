---
layout: post
title: Direct access to your webcam and microphone inside Google Colab notebook
category: deep_learning
draft: true
published: true
comments: true
---

Ok, this is a straight to the point post! In previous posts I explained how to save an image directly from your webcam. However, that method was using [OpenCV](https://opencv.org/) and it can only access hardware connected to the host (where the [Jupyter notebook](https://jupyter.org/) server is running). One classic example where you can't access a webcam directly is [Google Colaboratory](https://colab.research.google.com/). As I said at the beginning, you can only access the hardware from host, so the microphone also will not be available. Javascript to the rescue!
<!--more-->
For the first problem (capture image from your webcam) I modified something I found online (~~I couldn't find the author!~~ [here it is](https://colab.research.google.com/notebooks/snippets/advanced_outputs.ipynb#scrollTo=2viqYx97hPMi)). You can see the final notebook below (and you should be able to test it!)

<script src="https://gist.github.com/ricardodeazambuja/058f4c242fe67ec2d86ca2596b0905ad.js"></script>


The microphone demanded something a little bit more *hacky* and painful, so I had to dig deeper into [modern Javascript](https://developers.google.com/web/fundamentals/primers/promises) to make something that would work. It turned out I had to use [ffmpeg](https://www.ffmpeg.org/) because Chrome uses [matroska/webm](https://www.matroska.org/news/webm-matroska.html) and I couldn't find a way to decode it manually.

<script src="https://gist.github.com/ricardodeazambuja/03ac98c31e87caf284f7b06286ebf7fd.js"></script>

That's it! I hope you all will be able to create some cool stuff using [Google Colaboratory](https://colab.research.google.com/) now.