---
layout: post
title: Labeling images directly on Google Colab (colaboratory)
category: deep_learning
draft: true
published: true
comments: true
date: 2020-04-09 14:00:00
---

TL; DR: I like [Google Colab (Colaboratory)](https://colab.research.google.com/) and I use it quite a lot because that way I can work during the night without waking up my wife with my laptop's crazily loud gpu fan noises. Not so long ago [I wrote a post](https://ricardodeazambuja.com/deep_learning/2019/03/09/audio_and_video_google_colab/) where I shared two notebooks that allowed the user to save images and sounds directly from your webcam / mic to use inside a colab notebook.

Now, I put everything together in a python module and I added a super cool way to label images directly from a colab notebook! I'm not 100% sure, but I couldn't find anything like that after googling a lot.

Here is one example where I added some labels to an image captured from my webcam using a colab notebook:
<figure>
  <img src="{{ site.url }}/public/images/colab_utils_labeling.png?style=centerme" alt="colab_utils labeling example">
</figure>

For more details I suggest you to go straight to the [colab_utils repo](https://github.com/ricardodeazambuja/colab_utils).
