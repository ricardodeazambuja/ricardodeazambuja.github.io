---
layout: post
title: Testing my new TensorFlow / OpenCV / etc. docker image
category: deep_learning
draft: false
published: true
comments: true
---

My [last post]({{ site.url }}/deep_learning/2018/05/04/tuning_tensorflow_docker/) was all about creating a [TensorFlow](https://www.tensorflow.org/) [docker image](https://docs.docker.com/engine/reference/commandline/images/) that would work with [OpenCV](https://opencv.org/), inside a [Jupyter notebook](http://jupyter.org/), creating external windows, accessing the webcam, saving things using the current user from host, etc. All that hard work had a reason: use the newest version of TensorFlow for computer vision. So, let’s try it!  

<figure>
  <img src="{{ site.url }}/public/images/tensorflow_test.png?style=centerme" alt="First results from my TensorFlow docker image">
  <figcaption>Without the hat and the measuring tape, it was 0.9 for <i>mask</i> :disappointed_relieved:.</figcaption>
</figure>
<!--more-->

To test the docker image, I decided to try something simple to make my life easier if I get attacked by [bugs](http://villains.wikia.com/wiki/Cy-Bugs). Google suggested me the [official TensorFlow tutorials](https://www.tensorflow.org/tutorials/image_recognition) on image recognition, and I embraced the idea. I must admit, documentation is not the biggest strengh of TensorFlow. Google has been releasing new versions of TensorFlow super fast (current version is 1.8 and, according to github, since November 9, 2015 it had 58 releases!), therefore there are many ways to do the same thing and the documentation is not always updated to the last method. Also, it's easy to find many examples in the oficial documentation where they apply functions or methods that currently print messages saying they are deprecated! At first, I wanted to use some code together with [Tensorboard](https://www.youtube.com/watch?v=eBbEDRsCmv4) for this post, but I gave up because after watching the presentations from the [TensorFlow Dev Summit 2018](https://www.youtube.com/watch?v=RUougpQ6cMo&list=PLQY2H8rRoyvxjVx3zfw4vA4cvlKogyLNN) I got really confused about which one is the *latest* recommended way to use Tensorboard.

I have no idea since when, but TensorFlow has a special [repository with <s>pre-trained</s> models implemented in TensorFlow](https://github.com/tensorflow/models) (actually, the repo has *links* to the pre-trained models because github doesn't allow huge files anyway) and, following the tutorial I mentioned earlier, I will use an [Inception V3 (2015)](https://arxiv.org/abs/1512.00567) for my tests. Therefore, the first step is to clone the repo:

```
$ git clone https://github.com/tensorflow/models
```

By the way, the [docker image]({{ site.url }}/deep_learning/2018/05/04/tuning_tensorflow_docker/) does **NOT** have git installed. Consequently, you must clone the repo from the host. After cloning it, make sure your working directory is the `models/tutorials/image/imagenet`.

<figure>
  <img src="{{ site.url }}/public/images/cropped_panda.jpg?style=centerme" alt="Panda">
  <figcaption>Cropped image of a panda that comes with the <a href="http://download.tensorflow.org/models/image/imagenet/inception-2015-12-05.tgz">Inception V3 model</a>.</figcaption>
</figure>


Although I prepared a notebook based (copied?) from the tutorial's original Python script, it's always nicer to test something that has a *better* chance of working. It's super easy to execute a Python script from a notebook cell: `%run classify_image.py`. The results are here:
```
>> Downloading inception-2015-12-05.tgz 100.0%
Successfully downloaded inception-2015-12-05.tgz 88931400 bytes.
giant panda, panda, panda bear, coon bear, Ailuropoda melanoleuca (score = 0.89107)
indri, indris, Indri indri, Indri brevicaudatus (score = 0.00779)
lesser panda, red panda, panda, bear cat, cat bear, Ailurus fulgens (score = 0.00296)
custard apple (score = 0.00147)
earthstar (score = 0.00117)
```

As expected, it works! However, after I tried it again, it was faster than the first time :hushed:. Jupyter notebook kernel restarted, and I tested this:
```python
%%time
with tf.Session() as sess:
    pass
```

`Wall time: 603 ms`  
Remembering when I used to be a [Windows](https://en.wikipedia.org/wiki/Windows_7) day-by-day user, I decided to shut down the docker container and start again. Bingo!  
`Wall time: 2min 11s`.

[Asking Google](https://www.google.ca/search?q=tensorflow+cuda+slow+first+run) what the hell it was happening, I found a discussion on Github where someone said it was some kind of pre-compilation (JIT) that would happen only once because I'm probably using a compute capability that is different from what the image had before (yep, I’m using the GPU from my laptop: [GeForce 940MX, compute capability 5.0](https://en.wikipedia.org/wiki/CUDA#GPUs_supported)).

My solution was to commit the current container to my docker image. It was as simple as executing the command below (`objective_darwin` was the funny container's name running at that moment) on a different terminal:

```
$ docker commit -m "Fix the slow start of first session on TensorFlow" objective_darwin tensorflow_gpu_py3_ready:latest
```

It could also be automated by inserting the line below into the dockerfile used to create the docker image:
```
RUN python3 -c 'import tensorflow as tf; s=tf.Session()'
```

But it will not work because the gpu is not available by default! Before you build it using: 
```
docker build -t tensorflow_gpu_py3_ready -f New_Dockerfile .
```

You must first stop the docker daemon:
```
sudo service docker stop
```

And relaunch it using [a special option to enable the gpu](https://github.com/NVIDIA/nvidia-docker/wiki/Frequently-Asked-Questions#can-i-use-the-gpu-during-a-container-build-ie-docker-build):
```
sudo dockerd --default-runtime=nvidia
```

After that, you can kill the command above and start the service again:
```
sudo service docker start
```

The original TensorFlow Inception V3 model was created for reading directly from a file using a [DecodeJpeg](https://www.tensorflow.org/api_docs/cc/class/tensorflow/ops/decode-jpeg) *op* (one can also see it as a fancy node in your [dataflow graph](https://www.tensorflow.org/programmers_guide/graphs)). By using special nodes like that, TensorFlow can load *stuff* in an optimal way from disk speeding up things when you need to train your beast. The original script was:

```python
softmax_tensor = sess.graph.get_tensor_by_name('softmax:0')
predictions = sess.run(softmax_tensor,
                        {'DecodeJpeg/contents:0': image_data})
```

Here, instead of Tensorboard, I verified the [node names](https://www.tensorflow.org/extend/tool_developers/#nodes) by just printing the information about the Inception V3 nodes using a for loop:

```python
for node in graph_def.node:
    print(node.name, node.op, node.input)
```

The result from the for loop is too long (it's available in the last cell of the notebook at the end of this post anyway), so I will only show the first lines:

```
DecodeJpeg/contents Const []
DecodeJpeg DecodeJpeg ['DecodeJpeg/contents']
Cast Cast ['DecodeJpeg']
ExpandDims/dim Const []
ExpandDims ExpandDims ['Cast', 'ExpandDims/dim']
ResizeBilinear/size Const []
ResizeBilinear ResizeBilinear ['ExpandDims', 'ResizeBilinear/size']
Sub/y Const []
Sub Sub ['ResizeBilinear', 'Sub/y']
Mul/y Const []
Mul Mul ['Sub', 'Mul/y']
conv/conv2d_params Const []
conv/Conv2D Conv2D ['Mul', 'conv/conv2d_params']
```

According to the results and after some extra inspections, I realised I could pass the image captured from my webcam directly to `Cast`:

```python
predictions = sess.run(softmax_tensor,{'Cast:0': image_frame})
```

After that, it was just a matter of embellishment. Yet, I was not super happy with the results because the system was running at around 10 frames per second (fps). I did some tests and I thought I could improve it by having the image capturing part of the code running in parallel. I tried using [Queue](https://docs.python.org/3/library/multiprocessing.html#multiprocessing.Queue) and [Pipe](https://docs.python.org/3/library/multiprocessing.html#multiprocessing.Pipe). Below is the process I defined to run in parallel using Queue. It captures the exception `Full` so as soon as the queue (I set it for only 2 positions) has a slot it puts a new frame there. 

```python
from multiprocessing import Process, Queue

def read2queue(q):
    import cv2
    import queue
    capture = cv2.VideoCapture(0)
    grabbed = False
    while True:
        try:
            grabbed, image_frame = capture.read()
            if grabbed:
                q.put_nowait((grabbed,image_frame))
        except queue.Full:
            continue

frame_queue = Queue(2)
frame_proc = Process(target=read2queue, args=(frame_queue,))
frame_proc.daemon = True # to make sure it will die if its parent dies.

frame_proc.start()
```

The version using Pipe is simpler than the one above.

```python
from multiprocessing import Process, Pipe, connection

def read2pipe(pout, pin):
    from multiprocessing import Process, Pipe, connection
    import cv2
    capture = cv2.VideoCapture(0)
    grabbed = False
    while True:
        grabbed, image_frame = capture.read()
        if grabbed and not pout.poll():
            pin.send((grabbed,image_frame))
```

Finally, both parallel versions were actually a *wee* slower than the serial one. 


And, as promised, here is the full notebook :wink:.

<script src="https://gist.github.com/ricardodeazambuja/60787de1dd2d0e9725cc501084eb8f82.js"></script>

Cheers!

**UPDATE (17/05/2018): The line I suggested adding to the dockerfile was not working because, by default, the docker daemon doesn't use the nvidia runtime, therefore no gpu was available to run TensorFlow. The weird thing, still in need of an explanation, is why the command `RUN ["python3", "-c", "'import tensorflow as tf; s=tf.Session()'"]` was not raising an error and I could only see the gpu error when I changed it.**

**UPDATE (18/05/2018): The reason I [found](https://docs.docker.com/engine/reference/builder/#run) is that `RUN ["python3", "-c", "'import tensorflow as tf; s=tf.Session()'"]` uses [exec](https://linux.die.net/man/3/exec) and it seems to hide some errors that are internal to the program executed. E.g: `ls -0` shows `ls: invalid option -- '0'`, but `exec ls -0` hides it from the user.**

**UPDATE (31/01/2019): [New post with an UPDATED image is available!]({{ site.url }}/deep_learning/2019/01/31/tuning_tensorflow_docker_updated/)** 