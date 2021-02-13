---
layout: post
title: Using Google Coral Edge TPU USB accelerator to create a virtual (fake) webcam
category: python
draft: true
published: true
comments: true
date: 2021-02-13 00:00:00
---

<figure>
  <img src="{{ site.url }}/public/images/fakewebcam_coral_edgetpu.png?style=centerme" alt="Anynomized Webcam :)">
</figure>

After all that story about the [lawyer cat](https://www.youtube.com/watch?v=qcnnI6HD6DU), I decided to try to make something interesting to use during webinars, virtual meetings, etc. With the help of Google Coral Edge TPU USB Accelerator, it's possible to run deep neural models, with very high framerate, without the need of a GPU (and without all the noise coming from the colling fans). Above, I'm using segmentation to transform myself into some sort of semi-invisible blob while showing the results from [PoseNet](https://www.tensorflow.org/lite/models/pose_estimation/overview).

If you want to try it, you will need a computer running Linux and a [Google Coral Edge TPU USB Accelerator](https://coral.ai/products/accelerator). 

<!--more-->

## Here are the steps:
Install v4l2loopback-utils:  
```sudo apt install v4l2loopback-utils```

Then my fork of pyfakecam:  
```sudo pip3 install git+git://github.com/ricardodeazambuja/pyfakewebcam --upgrade```

Test if the virtual (fake) webcam is working by enabling the v4l2loopback and giving the virtual webcam the name `fake webcam`:  
```sudo modprobe v4l2loopback video_nr=2 card_label="fake webcam" exclusive_caps=1```

Now, save the code below as `webcam_test.py`:  
```
import time
import pyfakewebcam
import numpy as np

blue = np.zeros((480,640,3), dtype=np.uint8)
blue[:,:,2] = 255

red = np.zeros((480,640,3), dtype=np.uint8)
red[:,:,0] = 255

camera = pyfakewebcam.FakeWebcam("/dev/video2", 640, 480)

while True:

    camera.schedule_frame(red)
    time.sleep(0.5)

    camera.schedule_frame(blue)
    time.sleep(0.5)
```
If everything works as expected, you should be able to test it using this [WebRTC example](https://webrtc.github.io/samples/src/content/devices/input-output/) (it should show the option to select "fake webcam") and see the camera blinking red and blue. In case it doesn't work, first simply try to reboot your system. Still not working? Then I suggest [installing v4l2loopback from source](https://github.com/umlaeute/v4l2loopback).

Considering all the previous stuff worked (**don't forget to stop the previous script!**) the next step is to clone my fork of the Google Coral Project BodyPix:  
```git clone https://github.com/ricardodeazambuja/project-bodypix.git```

and install the requirements:
```sh install_requirements.sh```

The unusual requirements are: pillow, opencv-python, tflite-runtime and libedgetpu1-std.

Now, if you are lucky, plug your Google Coral Edge TPU USB Accelerator and run the `pyfakewebcam_example.py`:
```python3 pyfakewebcam_example.py```

You should be able to use any video conference software selecting the "fake webcam" (you can test using the [WebRTC example](https://webrtc.github.io/samples/src/content/devices/input-output/) again). You will see an *anonymize* the video stream where anything recognized as people will become a transparent blob!

Now I need to try to implement something like [that cat](https://www.youtube.com/watch?v=qcnnI6HD6DU). my plan is use the [Pose Animator](https://blog.tensorflow.org/2020/05/pose-animator-open-source-tool-to-bring-svg-characters-to-life.html), if you decide to do it before I do, please, let me know!



