---
layout: post
title: Running Ignition Gazebo Ionic on Google Colab
category: robotics
draft: true
published: true
comments: true
---

Last week, I saw [this post on LinkedIn](https://www.linkedin.com/posts/carlos-argueta_3d-robot-perception-ugcPost-7305742347311403008-qrAu/) where [Carlos Argueta](https://www.linkedin.com/in/carlos-argueta) was showing some interesting robotics perception experiments that were running on Google Colab.

I mentioned in the comments that I had, in the past, managed to run Gazebo on Google Colab. So, I decided to find that old notebook and here it's:

[https://colab.research.google.com/gist/ricardodeazambuja/fae4db3dcee352fee3f95966ca4f3ec6/example-virtual-screen-opengl-gazebo-ignition.ipynb](https://colab.research.google.com/gist/ricardodeazambuja/fae4db3dcee352fee3f95966ca4f3ec6/example-virtual-screen-opengl-gazebo-ignition.ipynb)

The magic is only possible thanks to open source software like [X virtual framebuffer](https://github.com/cgoldberg/xvfbwrapper), [VirtualGL](https://virtualgl.org/), [PyVirtualDisplay](https://github.com/ponty/PyVirtualDisplay), among others!

<figure>
  <img src="{{ site.url }}/public/images/IgnitionGazeboIonicRunningOnGoogleColab.png?style=centerme" alt="Ignition Gazebo Ionic Running on Google Colab">
  <figcaption>Ignition Gazebo Ionic Running on Google Colab</figcaption>
</figure>