---
layout: post
title: Easy-peasy Deep Learning and Convolutional Networks with Keras - Part 2
category: deep_learning
draft: false
published: true
comments: true
---

This is the continuation (finally!), or the *Part 2*, of the ["Easy-peasy Deep Learning and Convolutional Networks with Keras"]({{ site.url }}/deep_learning/2017/01/29/easy-peasy_deep_learning/). This post should be something self-contained, but you may enjoy reading [*Part&nbsp;1*]({{ site.url }}/deep_learning/2017/01/29/easy-peasy_deep_learning/) and [*Part&nbsp;1&frac12;*]({{ site.url }}/deep_learning/2017/02/12/easy-peasy_deep_learning_one_and_a_half/)... it's up to you.

Around one week ago, I'd attended a [CUDA workshop](https://sites.google.com/site/cudatraining/) presented (or should I say [conducted](https://books.google.com/ngrams/graph?content=workshop+presented%2Cworkshop+conducted&year_start=1800&year_end=2000&corpus=15&smoothing=3&share=&direct_url=t1%3B%2Cworkshop%20presented%3B%2Cc0%3B.t1%3B%2Cworkshop%20conducted%3B%2Cc0)?) by my friend [Anthony Morse](https://www.facebook.com/AmityFarm/) and I'm still astounded by [DIGITS](https://developer.nvidia.com/digits). So, during the workshop, I had some interesting ideas to use on this post!

The first thing I thought when I read (or heard?) for the first time the name **Convolutional Neural Network** was *a bunch of [filters](https://en.wikipedia.org/wiki/Kernel_(image_processing))* ([Gimp would agree with me](https://docs.gimp.org/en/plug-in-convmatrix.html)). I'm an Electrical Engineer and, for most of us (Electrical Engineers), convolutions start as nightmares and, gradually, become our almighty super weapon after a module like [Signal and Systems](https://ocw.mit.edu/resources/res-6-007-signals-and-systems-spring-2011/).

Let's start with something easy... a [video](https://www.youtube.com/watch?v=puxHUGpuOVw)! Below, you can observe, step-by-step, what happens when a 2D convolution (think about a [filter](https://en.wikipedia.org/wiki/Edge_detection) that detects, or enhances, edges) is applied to an image:

<div class="video-container" align="center">
<iframe width="854" height="480" src="https://www.youtube.com/embed/puxHUGpuOVw" frameborder="0" allowfullscreen></iframe>
</div>
<br />

<!--more-->

The *red'ish* 3x3 square moving around the cat's face is where the kernel (an [edged detector](https://en.wikipedia.org/wiki/Kernel_(image_processing)#Details)) is instantaneously applied. If the terms I'm using here are giving you [goosebumps](http://dictionary.cambridge.org/dictionary/english/goosebumps), try to read this first [deep learning glossary](http://www.wildml.com/deep-learning-glossary/) first. When I say *applied* I mean an [elementwise](http://www.scipy-lectures.org/intro/numpy/operations.html#id2) multiplication where the result is presented at the bottom (small square, really pixelated or 3x3 if you prefer). The picture, on the right hand side, is the sum of the values (you can visualize them on the small square figure at the bottom) at that instant (but the scales now are different, final result uses [absolute values](https://en.wikipedia.org/wiki/Absolute_value)). If you, like me, thinks my explanation above is very poor and you want to understand what is really happening (e.g. Why does the original image have a black border?), I would suggest you to have a look on these websites: [CS231n](http://cs231n.github.io/convolutional-networks), [Colah's](http://colah.github.io/posts/2014-07-Understanding-Convolutions/) and [Intel Labs' River Trail project](http://intellabs.github.io/RiverTrail/tutorial/). The figure below, taken from Intel's website, is ([IMHO](https://en.wiktionary.org/wiki/IMHO)) *the killer* explanation:

<figure>
  <img src="{{ site.url }}/public/images/convolution_intellabs.png?style=centerme" alt="What happens when we do a 2D convolution">
  <figcaption>This is exactly what I did to create the video. <i>Image from <a href='http://intellabs.github.io/RiverTrail/tutorial/'>Intel Labs' River Trail project</a></i>.</figcaption>
</figure>

Nevertheless, this post is supposed to be *easy-peasy&reg;* style and I will not change it now. My definition for [convolution](https://en.wikipedia.org/wiki/Convolution) is: a close relative of [cross-correlation](https://en.wikipedia.org/wiki/Cross-correlation) (pay attention to *&tau;* and *t* if you decide to follow the previous link and have a closer look at the initial animation I've presented) and very good friend of [dot product](https://en.wikipedia.org/wiki/Dot_product) (try to [flatten](https://docs.scipy.org/doc/numpy/reference/generated/numpy.ndarray.flatten.html) things and it will be easier to spot it) - even the symbols have a strong resemblance. *Improving* even further my *easy-peasy&reg;* description, another way to describe what a convolution is would be by saying it is like rubbing one function (our [kernel](https://en.wikipedia.org/wiki/Kernel_(image_processing))) against another one and taking note of the result while you do it :satisfied:.

I'm starting to hate this idea of having this *outline thing*... but I will try to keep using it! If I got it right, after reading (writing, in my situation) everything and trying to figure out where all things came from and why, we should be able to:

- [ ] Undoubtedly convince ourselves [Keras](https://keras.io/) is cool!
- [ ] Create our first very own **Convolutional** Neural Network.
- [ ] Understand there's no magic! (but if we just had [enough monkeys](https://en.wikipedia.org/wiki/Infinite_monkey_theorem)...)
- [ ] Get a job on Facebook... ok, we will need a lot more to impress [Monsieur Lecun](http://yann.lecun.com/), but this is a starting point :bowtie:.
- [ ] And, finally, enjoy our time while doing all the above things!


Ok, ok, ok... let's get back to [Keras](https://keras.io/) and our [*precious*](https://www.youtube.com/watch?v=Iz-8CSa9xj8) Convolutional Neural Networks ([aka](https://en.wikipedia.org/wiki/Aka) **CNNs**) :wink:.

Do you remember I said CNNs were just *a bunch of filters*? I was not lying or making fun of you. CNNs are a mixture between a fancy [filter bank](https://en.wikipedia.org/wiki/Convolution) and [Feedforward Neural Networks](https://cs.stanford.edu/people/eroberts/courses/soco/projects/neural-networks/Architecture/feedforward.html), but everything works together with the help of our friend [backpropagation](http://cs231n.github.io/optimization-2/). Recalling from [Part&nbsp;1]({{ site.url }}/deep_learning/2017/01/29/easy-peasy_deep_learning/), our network was initially designed only using [Kera's Dense layers](https://keras.io/layers/core/#dense):

```python
# Just creates our Keras Sequential model
model = Sequential()

# The first layer will have a uniform initialization
model.add(Dense(768, input_dim=3072, init="uniform"))
# The ReLU 'thing' :)
model.add(Activation('relu'))

# Now this layer will have output dimension of 384
model.add(Dense(384, init="uniform"))
model.add(Activation('relu'))

# Because we want to classify between only two classes (binary), the final output is 2
model.add(Dense(2))
model.add(Activation("softmax"))
```

And **what is the problem with the classical layers?** [Theoretically](https://en.wikipedia.org/wiki/Connectionism), **none**. One could, somehow, train a network with enough data to do the job. However, [backpropagation is not so powerful](https://en.wikipedia.org/wiki/Vanishing_gradient_problem) and it would probably demand networks [a lot bigger](http://cs231n.github.io/convolutional-networks/#overview) (this is my [TL;DR](https://en.wikipedia.org/wiki/TL;DR) explanation, so go and use your inner [*google-fu*](http://lifehacker.com/5940946/20-google-search-shortcuts-to-hone-your-google-fu) if you are not satisfied :grimacing:).

CNNs are, IMHO, the engineer's approach! They are useful because they can generate (filter out) nice features from its inputs making the life easier for [Dense layers](https://keras.io/layers/core/#dense) after that. Do you remember [the last post of our *easy-peasy&reg;* series]({{ site.url }}/deep_learning/2017/01/29/easy-peasy_deep_learning_one_and_a_half/)? Ok, I would not expect anybody to fully remember anything, but that post was created because I realized visualization of internal layers was super important and I will bring back one important figure from there:

<figure>
  <img src="{{ site.url }}/public/images/output_trained.png?style=centerme" alt="Layers output as images">
  <figcaption>This is what my trained network from Part&nbsp;1&frac12; outputs (not the CNN!), but viewed as RGB images.</figcaption>
</figure>

The first image is *clearly* a dog, but the second image (composed by the output from the first layer) is totally crazy and doesn't look like having features to distinguish dogs from cats! So, the important bit is that I (or maybe a dense layer too) can't even find any tiny visual clue from that image that would suggest there was a dog as input. That doesn't mean there are no distinguishable features, but the features are hard to spot.

Now let's see what happens when we use a convolutional layer:

<figure>
  <img src="{{ site.url }}/public/images/conv_layer1.png?style=centerme" alt="Layers output as images">
  <figcaption>Now, our brand new CNN outputs something different from its first layer.</figcaption>
</figure>

Probably, the first thing I would notice here is the number of images after the first layer. Our convolutional layer created 32, different, filtered versions of its input! Kind of cheating...

In order to have the above result, we need to replace, in our old model, the first [`Dense`](https://keras.io/layers/core/#dense) layer with a [`Convolution2D`](https://keras.io/layers/convolutional/#convolution2d) one:

```python
model.add(Convolution2D(number_of_filters,
                        kernel_size[0],
                        kernel_size[1],
                        border_mode='same',
                        input_shape=input_layer_shape,
                        name='ConvLayer1'))
```

Where:

```
number_of_filters=32
kernel_size=(3,3)
```

This layer is composed by 32 filters (that is why we got 32 output images after the first layer!), each filter 3x3x3 (remember our input images are colorful [RGB](http://stackoverflow.com/questions/25102461/python-rgb-matrix-of-an-image) ones, therefore they have one 3x3 matrix for each color), and it will output 32 images 32x32 because `border_mode='same'`. It's crystal clear that this behaviour would lead to an [explosion](https://en.wikipedia.org/wiki/Geometric_series) because the next layer would always be 32x bigger than the previous... but **not**! If we read the [Convolution2D manual](https://keras.io/layers/convolutional/#convolution2d), this layer receives a 4D [Tensor](http://www.physlink.com/education/askexperts/ae168.cfm), returns a 4D Tensor (no extra dimension created) and, consequently, no explosion at all because the generated weights do the magic of combining things for us :sweat_smile:. If we verify the shape of the weights tensor, the first convolutional layer weights tensor has shape (32, 3, 3, 3) and the second convolutional layer has shape (8, 32, 3, 3). Remember, the input image is (3, 32, 32), the first layer has 32 filters and the second only 8.

Even though the explosion problem does not afflict us, I will condense the features before the last fully-connected Keras `Dense` layer to speed up things by reducing the total number of weights and, therefore, calculations. The solution for this is the use of a shrinking layer and the [pooling layer](https://en.wikipedia.org/wiki/Convolutional_neural_network#Pooling_layer) is what we need. From Keras, we will use a [`Maxpooling2d`](https://keras.io/layers/pooling/#maxpooling2d) layer with `pool_size=(2,2)` and it will shrink our 32x32x32 output down to 32x16x16. The reduction from 32x32 to 16x16 is done by keeping the biggest value (probably that's the reason of starting with "Max") inside the 2x2 pool.

```python
model.add(Convolution2D(number_of_filters,
                        kernel_size[0],
                        kernel_size[1],
                        border_mode='same',
                        input_shape=input_layer_shape,
                        name='ConvLayer2'))

model.add(Activation('relu',
                     name='ConvLayer2Activation'))

model.add(MaxPooling2D(pool_size=pool_size,
                       dim_ordering='th',
                       name='PoolingLayer2'))
```

Since this *easy-peasy&reg;* series was not designed to beat benchmarks, but mainly to learn and understand what is happening, I will add one more set of convolutional and pooling layers. Moreover, I will reduce the number of filters from 32 to 8. I really want to see changes on the internal weights, even if this generates overfitting, thus I've increased the epochs to 1000. Apart from the things I've explained here so far, everything else will be kept the same as the [Part 1]({{ site.url }}/deep_learning/2017/01/29/easy-peasy_deep_learning/) and [Part&nbsp;1&frac12;]({{ site.url }}/deep_learning/2017/01/29/easy-peasy_deep_learning/) posts.

Testing our new CNN against the test set (the 25% randomly chosen images from the directory train) returned us a accuracy of... 97%! You can find the saved model [here](https://github.com/ricardodeazambuja/keras-adventures/blob/master/Dogs_vs_Cats/my_convnet_SDG.h5?raw=true).

<figure>
  <img src="{{ site.url }}/public/images/dog_vs_cat_conv_test_set.png?style=centerme" alt="dogs-vs-cats">
  <figcaption>Testing the Convolutional Neural Network against images from the test set.</figcaption>
</figure>

And below you can see what appears inside the CNN with the dog:

<figure>
  <img src="{{ site.url }}/public/images/conv_layer1.png?style=centerme" alt="dogs-vs-cats">
  <figcaption>First Layer internal results using the dog image.</figcaption>
</figure>

<figure>
  <img src="{{ site.url }}/public/images/conv_layer2.png?style=centerme" alt="dogs-vs-cats">
  <figcaption>Second Layer internal results using the dog image.</figcaption>
</figure>

In order to help us verify the differences between dogs and cats, here are the images where a cat was the input:

<figure>
  <img src="{{ site.url }}/public/images/conv_layer1_cat.png?style=centerme" alt="dogs-vs-cats">
  <figcaption>First Layer internal results using the cat image.</figcaption>
</figure>

<figure>
  <img src="{{ site.url }}/public/images/conv_layer2_cat.png?style=centerme" alt="dogs-vs-cats">
  <figcaption>Second Layer internal results using the cat image.</figcaption>
</figure>

After all that, I was not 100% sure if Keras was really doing convolution or cross-correlation. Instead of searching for an answer, I decided to verify it myself. First, I save the trained weights:

```python
layer_name = 'ConvLayer1'
weights_conv1 = model.get_layer(layer_name).get_weights()[0]
bias_conv1 = model.get_layer(layer_name).get_weights()[1]

layer_name = 'ConvLayer2'
weights_conv2 = model.get_layer(layer_name).get_weights()[0]
bias_conv2 = model.get_layer(layer_name).get_weights()[1]
```

And then I manually do the convolution (same previous dog picture) using Scipy [`convolve2d`](https://docs.scipy.org/doc/scipy/reference/generated/scipy.signal.convolve2d.html).

```python
idx = 1
input_image = testData[idx]

result = []

for i in range(3):
    result.append(convolve2d(input_image[i],
                             weights_conv1[0][i],
                             mode='same',
                             boundary='fill'))
result = numpy.array(result)
```

<figure>
  <img src="{{ site.url }}/public/images/dog_scipy_conv2d.png?style=centerme" alt="dogs-vs-cats">
  <figcaption>Result of Scipy convolve2d.</figcaption>
</figure>

Followed by the cross-correlation using Scipy [`correlate2d`](https://docs.scipy.org/doc/scipy/reference/generated/scipy.signal.correlate2d.html).

```python
idx = 1
input_image = testData[idx]

result = []

for i in range(3):
    result.append(correlate2d(input_image[i],
                              weights_conv1[0][i], mode='same'))
result = numpy.array(result)
```

<figure>
  <img src="{{ site.url }}/public/images/dog_scipy_corr2d.png?style=centerme" alt="dogs-vs-cats">
  <figcaption>Result of Scipy correlate2d.</figcaption>
</figure>

In the end I do a convolution using a cross-correlation (remember the *&tau;* and *t* signal change):

```python
idx = 1
input_image = testData[idx]

result = []

for i in range(3):
    result.append(correlate2d(input_image[i],
                            numpy.fliplr(numpy.flipud(weights_conv1[0][i])), mode='same'))
result = numpy.array(result)
```

<figure>
  <img src="{{ site.url }}/public/images/dog_scipy_corr2d_flipped.png?style=centerme" alt="dogs-vs-cats">
  <figcaption>Result of Scipy correlate2d, but flipping things (look again the convolution2d result).</figcaption>
</figure>

That's it, all done!

Lastly, let's see what we have achieved:

- [x] Undoubtedly convince ourselves [Keras](https://keras.io/) is cool!
- [x] Create our first very own **Convolutional** Neural Network.
- [x] Understand there's no magic! (but if we just had [enough monkeys](https://en.wikipedia.org/wiki/Infinite_monkey_theorem)...)
- [ ] Get a job on Facebook... ok, we will need a lot more to impress [Monsieur Lecun](http://yann.lecun.com/), but this is a starting point :bowtie:.
- [x] And, finally, enjoy our time while doing all the above things!

I was almost forgetting, we can tick this box from the first [post]({{ site.url }}/deep_learning/2017/01/29/easy-peasy_deep_learning/):

- [x] Show off by modifying the previous example using a convolutional layer.

Alright, we still need to do a lot more to get that Facebook job position... but in [Southern Brazil](https://en.wikipedia.org/wiki/Gaucho), we have a saying *"Não tá morto quem peleia"* that I would translate as *"If you can still fight, the battle is not over"* :smile:.

As promised, [here](http://nbviewer.jupyter.org/github/ricardodeazambuja/keras-adventures/blob/master/Dogs_vs_Cats/Keras%20Cats%20and%20Dogs%20-%20convolutional%20deep%20net%20(not%20so%20deep)%20-%20Final.ipynb) you can visualize (or download) a [Jupyter (IPython) notebook](https://ipython.org/notebook.html) with all the source code and something else.

And that's all folks! I hope you enjoyed our short Keras adventure. Cheers!
