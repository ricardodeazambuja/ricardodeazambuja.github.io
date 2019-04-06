---
layout: post
title: Interactively playing with MNIST
category: deep_learning
draft: true
published: true
comments: true
date: 2019-04-06 10:00:00
---

<figure>
  <img src="{{ site.url }}/public/images/interactive_mnist.png?style=centerme" alt="My interactive MNIST toy running on a Jupyter notebook">
</figure>

The very first example you use to introduce neural nets to students nowadays is always something based on [MNIST handwritten numbers](http://yann.lecun.com/exdb/mnist/). Therefore, I decided to create an interactive notebook where you can directly draw your digits to test your brand new trained neural net.

<!--more-->

The notebook, embed below, is pretty much self-explanatory, but it has some caveats. It is based on **old** TensorFlow when we consider the new version 2.0 (today is 06/04/2019). Additionally, Matplotlib and Jupyter have problems when you switch the backend between the notebook and the inline ones.

Ok, that's it, I hope someone else [enjoys and makes a good use of it](https://gist.github.com/ricardodeazambuja/65bcfa955d448dd9136b71d737bfa607) too ;)

<script src="https://gist.github.com/ricardodeazambuja/65bcfa955d448dd9136b71d737bfa607.js"></script>