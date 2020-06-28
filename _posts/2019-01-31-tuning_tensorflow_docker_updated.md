---
layout: post
title: An UPDATED TensorFlow docker image to rule them all
category: deep_learning
draft: true
published: true
comments: true
---

<figure>
  <img src="{{ site.url }}/public/images/tensorflow_tuning_updated.png?style=centerme" alt="TensorFlow+OpenCV+Access to local HD+docker">
</figure>
<!--more-->

**UPDATE (28/06/2020): NVIDIA container toolkit changed! [See their repository for more details](https://github.com/NVIDIA/nvidia-docker#ubuntu-160418042004-debian-jessiestretchbuster). Now, instead of ` --runtime=nvidia `, you should use ` --gpus all `.**

Many months ago, I prepared a [docker image using Tensorflow, OpenCV, Dlib, etc](https://ricardodeazambuja.com/deep_learning/2018/05/04/tuning_tensorflow_docker/). Tensorflow was still in its version 1.8.0 and I can't even remember what was the docker version at that time. However, at the end of August (2018) my career took a turn and I got a new job as a Postdoctoral Research Fellow at [MIST Lab](http://mistlab.ca/) where I started working on a project using [UAVs](https://en.wikipedia.org/wiki/Unmanned_aerial_vehicle). To be more precise, I was working with a 3DR Solo from 2016 that I managed to upgrade to the [OpenSolo](https://github.com/OpenSolo) stack. It was my first time playing with drones so I had a lot to learn in a very short period of time. After around one month of work in this project, I was told we would have a demo where I had to present an automatic landing system based on [fiducial markers](https://en.wikipedia.org/wiki/Fiducial_marker)... in a little more than one month! Following the first demo it was decided to prepare a second demo, but now indoors and using a motion capture system ([OptiTrack](https://optitrack.com/)). During all this period I was working like crazy to catch up with the UAV knowhow I was lacking. That's the reason why I took so long to update my docker image :stuck_out_tongue_winking_eye:.

This time my constraint was my [GeForce 940MX](https://www.geforce.com/hardware/notebook-gpus/geforce-940mx). My new docker image would need to be compatible with my laptop. Additionally, I wanted to install the latest GPU enabled versions of Tensorflow, OpenCV and Dlib. The final main selection:
```
- Tensorflow 1.12 (GPU version)
- OpenCV4.0.1 (compiled for GPU)
- Dlib 19.16 (compiled for GPU)
- Ubuntu 16.04
- CUDA 9.0 (the GeForce 940MX refused to work with CUDA > 9.0)
- cuDNN7.2.1.38
```

To make life easier for my ~4 (???) faithful readers (counting my relatives...), I decided to push the image to [Docker Hub](https://hub.docker.com/r/ricardodeazambuja/tensorflow_gpu_py3_opencv_dlib_jupyter). Therefore you *just* need to run this command to have everything up and running:
```
docker run --rm -it --runtime=nvidia \
             --user $(id -u):$(id -g) \
             --group-add video --group-add sudo \
             -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix \
             --device=/dev/video0:/dev/video0 \
             -v $(pwd):/tf/notebooks -p 8888:8888 \
             ricardodeazambuja/tensorflow_gpu_py3_opencv_dlib_jupyter:tf119-cuda90-dlib1916-opencv4
```

It will be much easier if you add the code below to the end of your `~/.bashrc` file:
```
alias ai_docker='docker run --rm -it --runtime=nvidia \
             --user $(id -u):$(id -g) \
             --group-add video --group-add sudo \
             -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix \
             --device=/dev/video0:/dev/video0 \
             -v $(pwd):/tf/notebooks -p 8888:8888 \
             ricardodeazambuja/tensorflow_gpu_py3_opencv_dlib_jupyter:tf119-cuda90-dlib1916-opencv4' 
```
I'm almost sure I explained all the arguments above in an [older post](https://ricardodeazambuja.com/deep_learning/2018/05/04/tuning_tensorflow_docker/).

You can also pull the image first:
```
docker pull ricardodeazambuja/tensorflow_gpu_py3_opencv_dlib_jupyter:tf119-cuda90-dlib1916-opencv4
```

As long as I understood, thanks to the evolution of Docker (I'm using version 18.09.1 currently), this new image doesn't need some of the hacks from [my last one](https://ricardodeazambuja.com/deep_learning/2018/05/04/tuning_tensorflow_docker).

The Dockerfile I created is far from optimized. I added everything I thought it could be useful and the final image became quite big. I really don't care whether it is 1 or 5GB. If you do, you can modify it to your [*bear necessities*](https://www.youtube.com/watch?v=c6e3ITsjLRI) by changing my [Dockerfile](https://gist.github.com/ricardodeazambuja/bdd59d9e2e9bae67313c8f6bd3da76a8).

When you run the image, it will show you something like this:
```

________                               _______________                
___  __/__________________________________  ____/__  /________      __
__  /  _  _ \_  __ \_  ___/  __ \_  ___/_  /_   __  /_  __ \_ | /| / /
_  /   /  __/  / / /(__  )/ /_/ /  /   _  __/   _  / / /_/ /_ |/ |/ / 
/_/    \___//_/ /_//____/ \____//_/    /_/      /_/  \____/____/|__/


You are running this container as user with ID 1000 and group 1000,
which should map to the ID and group for your user on the Docker host. Great!

[I 18:45:47.192 NotebookApp] Writing notebook server cookie secret to /home/container_user/.local/share/jupyter/runtime/notebook_cookie_secret
[I 18:45:47.378 NotebookApp] Serving notebooks from local directory: /tf
[I 18:45:47.378 NotebookApp] The Jupyter Notebook is running at:
[I 18:45:47.378 NotebookApp] http://localhost:8888/?token=769d3be612fbefa4d3c16d0b1506ef9744610bb7c8cb9932
[I 18:45:47.378 NotebookApp] Use Control-C to stop this server and shut down all kernels (twice to skip confirmation).
[C 18:45:47.382 NotebookApp] 
    
    To access the notebook, open this file in a browser:
        file:///home/container_user/.local/share/jupyter/runtime/nbserver-12-open.html
    Or copy and paste one of these URLs:
        http://localhost:8888/?token=769d3be612fbefa4d3c16d0b1506ef9744610bb7c8cb9932

```

If you are using Ubuntu, you will be able to right click on the last link (not the ones on this post...) and select `Open Link` to open a webpage with Jupyter.  

<div class="message">
  Docker will mount the current directory under '/notebooks' and ONLY the files/folders created/modified/saved under the directory '/notebooks' will be saved. Everything else will change into fairy dust after you close your container ;)
</div>

Another thing you should be aware is JIT compiler. I explained this *problem* [before](https://ricardodeazambuja.com/deep_learning/2018/05/12/testing-tensorflow-docker/), so I will not do it again... but I'm a nice guy and I will repeat the steps.

First, you will need to launch your image *WITHOUT* the `--rm` argument:
```
docker run -it --runtime=nvidia \
             --user $(id -u):$(id -g) \
             --group-add video --group-add sudo \
             -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix \
             --device=/dev/video0:/dev/video0 \
             -v $(pwd):/tf/notebooks -p 8888:8888 \
             ricardodeazambuja/tensorflow_gpu_py3_opencv_dlib_jupyter:tf119-cuda90-dlib1916-opencv4
```

Second, do the right click thing to launch Jupyter on your browser, open a notebook and execute the code below:
```
%%time

import tensorflow as tf

with tf.Session() as sess:
    pass
```

My laptop took around 3min to finish it. Now, you can close the notebook, stop your container (Ctrl+C twice while in the terminal you launched it) and verify the container ID or name:
```
docker ps -a
```

In my situation, the container ID was `abd33d457120`. The next command will commit the changes to your local image:
```
docker commit -m "Fix the slow start of first session on TensorFlow" abd33d457120 ricardodeazambuja/tensorflow_gpu_py3_opencv_dlib_jupyter:tf119-cuda90-dlib1916-opencv4
```

Since we don't need that container anymore, let's remove it using the container ID:
```
docker rm abd33d457120
```

I launched a new container (now using the original command with --rm) and tested the time:
```
%%time

import tensorflow as tf

with tf.Session() as sess:
    pass
```
Sweet... It took only 1.6s!!!!

And that's it! Now I have an UPDATED docker image that has *everything* I need and follows docker's philosophy of being a clean slate when you create a new container.