---
layout: post
title: Loss function for semantic segmentation using PyTorch (CrossEntropyLoss and BCELoss)
category: deep_learning
draft: true
published: true
comments: true
---

Today I was trying to implement, using PyTorch, the Focal Loss ([paperswithcode](https://paperswithcode.com/method/focal-loss), [original paper](https://arxiv.org/abs/1708.02002)) for my semantic segmentation model. Focal Loss is "just" Cross Entropy Loss with some extra sauce that allows you to adjust (&lambda;) how much weight you give to examples that are harder to classify otherwise your optimiser will `focus` on the easy examples because they have more impact on the loss. To save time, I didn't even considered writing my own code (although the focal loss is fairly simple), and I went directly to google where I found [this nice example](https://github.com/VainF/DeepLabV3Plus-Pytorch/blob/0c67dce524b2eb94dc3587ff2832e28f11440cae/utils/loss.py):
<!--more-->

```python
import torch.nn as nn
import torch.nn.functional as F
import torch 

class FocalLoss(nn.Module):
    def __init__(self, alpha=1, gamma=0, size_average=True, ignore_index=255):
        super(FocalLoss, self).__init__()
        self.alpha = alpha
        self.gamma = gamma
        self.ignore_index = ignore_index
        self.size_average = size_average

    def forward(self, inputs, targets):
        ce_loss = F.cross_entropy(
            inputs, targets, reduction='none', ignore_index=self.ignore_index)
        pt = torch.exp(-ce_loss)
        focal_loss = self.alpha * (1-pt)**self.gamma * ce_loss
        if self.size_average:
            return focal_loss.mean()
        else:
            return focal_loss.sum()
```

The example above uses [PyTorch's CrossEntropyLoss](https://pytorch.org/docs/stable/generated/torch.nn.CrossEntropyLoss.html), and that caused problems because I had only one output mask in the model I was testing. The CrossEntropyLoss would not spit any error, just give me `0` or `-0`. Long story short, I couldn't find clear usage examples for images (2D), therefore I created [this gist](https://gist.github.com/ricardodeazambuja/7b079fc8426d860b73666873e2dafa50) that you can find embedded below:

<script src="https://gist.github.com/ricardodeazambuja/7b079fc8426d860b73666873e2dafa50.js"></script>