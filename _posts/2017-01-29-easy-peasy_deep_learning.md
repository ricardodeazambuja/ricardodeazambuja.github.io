---
layout: post
title: Easy-peasy Deep Learning and Convolutional Networks with Keras
category: deep learning
draft: true
---
Deep learning... wow... this is "the" hot topic since, at least, some good years ago! I've attended a few seminars and workshops about deep learning, nevertheless I've never tried to code something myself - until now! - because I had always another [priority](http://www.tastefullyoffensive.com/2013/09/the-12-types-of-procrastnators.html). Also, I have to admit, I thought it was a lot harder and it would need much more time to be able to run anything that was not simply a sample code.

Since I've just learned how to use these cool check boxes on Markdown, let's write down an outline of what we want to achieve at the end of this post:

- [ ] Convince ourselves learning [Keras](https://keras.io/) is a nice investment!
- [ ] Create our very own first deep neural network (ok, not *that* deep).
- [ ] And, to show off, modifying the previous example using a convolutional neural network.
- [ ] Enjoy our time because when you work on something you like, it is not work anymore!

Am I going to reinvent the wheel? Hopefully not! I will use my very strong [*Google-fu*](https://en.wiktionary.org/wiki/Google-fu) to find something we can reuse. The first result Google gave me was [this](http://www.pyimagesearch.com/2016/09/26/a-simple-neural-network-with-python-and-keras/). The [pyimagesearch](http://www.pyimagesearch.com) website is a very good source of things related to image processing, but, I'll have to admit, I don't like the way the guy deals with his readers forcing them to use his own library and to subscribe to be able to download source code... however, he is sharing knowledge and this is a good thing :relieved:. My intention here is to partially follow his steps with some changes introduced because I thought were useful or just a matter of personal taste :satisfied: (I'm using a lot of emojis because I've just found this [emoji cheat sheet](http://www.webpagefx.com/tools/emoji-cheat-sheet/)).

By the way, I'm supposing [Keras](https://keras.io/) and [Theano](http://deeplearning.net/software/theano/) or [TensorFlow](https://www.tensorflow.org/) are already installed, up and running. My personal experience tells me Theano is easier to install than TensorFlow, but, maybe, I was just unlucky/lucky :sunglasses:.

I'm using Theano on a laptop that has a GeForce GT 750M GPU, but I have found one caveat related to amount of memory available (the system shares its main memory with the GPU). To have more control, I created a file on my user's home directory called *.theanorc* with this content:

```
[global]
floatX=float32
device = gpu0

[lib]
cnmem = .7
```

Theano can run on CPU or CPU+GPU. It will autonomously choose the CPU only mode if the GPU is not available. However, my system has a GPU and I was not able to activate its use on Theano. That's the reason why I created the *.theanorc* file. The line `device = gpu0` forces Theano to use the GPU (if you have more than one, maybe it will not be `gpu0`) and the line `cnmem = .7` sets the amount of memory used by [CNMeM](http://deeplearning.net/software/theano/library/config.html#config.config.lib.cnmem). If you don't have enough memory available (laptops usually share the main memory with the GPU), it will give you an error message. Setting `cnmem = 0` disables it.

Before we start *deep learning*, we are going to need the data set from [Kaggle Dogs vs. Cats](https://www.kaggle.com/c/dogs-vs-cats). This data set has 25000 images divided into training (12500) and testing (12500) sets. The training one has the filenames like these examples: `cat.3141.jpg` and `dog.3141.jpg`, while in the testing set the files are only a number with the `.jpg` extension. I'm trying to beat a state of art algorithm ([not even an old one](http://xenon.stanford.edu/~pgolle/papers/dogcat.pdf)), but only to learn how to use Keras.

If you have a look at the images you just downloaded, you will notice they're not all the same size. Later, we will need to simplify things or it will take ages to train, run, etc. I will consider the data sets are, now, installed in two directories (folders, for the young ones) named: `train` and `test1`. We will need to read the images and store their filenames as well. Since we will have a loop going on, the images will pass through a downsampling to reduce their sizes too. I will use `scipy.misc.imresize` because, IMHO, it's a lot easier to install [PIL/Pillow](https://pypi.python.org/pypi/Pillow/2.2.1) than [OpenCV](https://www.google.co.uk/webhp?q=installing+opencv+python) :innocent:.

Even though it's not a good practice, I will import the packages only when they are necessary. Python is just fine with that and it is so clever that it will not import twice the same thing. At the end I will supply a file with the whole source code and, then, the imports will be all at the top (if I don't miss anyone...:cold_sweat:).

Another *small* detail: the neural network we will create here only accepts one dimensional (1D) vector (or list or array, you choose the name). For that reason, we will flatten (transform it into a 1D thing) after resizing (downsampling).

```python
# The package 'os' will be necessary to find the current
# working directory os.getcwd() and also to list all
# files in a directory os.listdir().
import os

# As I've explained somewhere above, Scipy will help us
# reading (using Pillow) and resizing images.
import scipy.misc


path = os.getcwd()+"/"
dirname = "train"
imagePaths = [path+dirname+"/"+filename for filename in os.listdir(path+dirname)]
```




<div class="message">
  This is a draft... yep, I'm learning how to use Jekyll and I do test things on the production website :bowtie:
</div>
