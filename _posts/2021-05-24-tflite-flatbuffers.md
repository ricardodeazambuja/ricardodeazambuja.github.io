---
layout: post
title: Studying Flatbuffers to play with TFLite models
category: deep_learning
draft: true
published: true
comments: true
date: 2021-05-23 00:00:00
---

I may write another post in the near future about this, but for now it will be yet another *very-short-post&trade;* :wink:. I'm working with Tiny ML (or Edge AI or simply *trying to run complex stuff on not-so-great hardware*) and, currently, my focus is on [Google Coral EdgeTPU](https://coral.ai/). In general, I like [Google](https://duckduckgo.com/), [TensorFlow](https://www.tensorflow.org/), etc, but a lot of the things they release are badly documented (or the documentation is just plain outdated) and others simply overcomplicated (ok, it may be useful when many people work on the same codebase...). Sometimes, I even think this is some sort of business strategy because a gigantic company like Google couldn't do these things by mistake, but who knows. So, back to [TFLite](https://www.tensorflow.org/lite) models, most of the users know they are [Flatbuffers](https://google.github.io/flatbuffers/), but it's so annoyingly hard to make simple things because you can't find proper documentation (a Google search should **ALWAYS** return perfect results related to Google stuff, shouldn't it????).

<!--more-->

I found [an amazing blog(?) post](https://towardsdatascience.com/hacking-google-coral-edge-tpu-motion-blur-and-lanczos-resize-9b60ebfaa552) (just open using a incognito / private tab if medium tells you can't read it) where the author (Vadim) dissects a tflite model and even changes its behaviour! Everything I would expect to learn from... Google!!!

To start with, you need flatc, but, afaik, it's not available anywhere as an executable and you need to compile it yourself. Not the hardest thing, but annoying anyway. To solve this problem, I compiled it (Linux, x86_64) and put it [here](https://github.com/ricardodeazambuja/flatbuffers/releases/tag/v2.0.0).

Now, let's cut to the chase: you use flatc together with the correct schema for the tflite version you have, and you can generate a json file that you can modify using Python! First download the schema (change to schema_v3a, v3, v2...v0 if you need):

```wget https://raw.githubusercontent.com/tensorflow/tensorflow/master/tensorflow/lite/schema/schema.fbs```

And convert your tflite model to json (schemas below v3 will need an extra ```--raw-binary``` argument):

```flatc -t  --strict-json --defaults-json schema.fbs -- model.tflite```

Play with your json model using Python:
```
import json

with open("model.json") as f:
  model_json = json.load(f)

...

with open('model_mod.json', 'w') as f:
    json.dump(model_json, f)
```

And finally convert it back to tflite:

```flatc -b --strict-json --defaults-json -o flatc_output schema.fbs model_mod.json```

I hope this will be useful to someone else... and I just wish this will be eventually incorporated to [Netron](https://github.com/lutzroeder/netron) :sweat_smile:
(BTW, I rediscovered my theme had emojis)