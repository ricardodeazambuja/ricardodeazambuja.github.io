---
layout: post
title: Variable Power Supply, with Current Limitation, from Commercial Off-the-Shelf parts... powered by USB-C!
category: electronics
draft: true
published: true
comments: true
date: 2021-07-05 00:00:00
---

From time to time I have a project with some electronics that need testing. This weekend I was checking how to power my [Maple Syrup Pi Camera](https://github.com/ricardodeazambuja/Maple-Syrup-Pi-Camera) with a solar panel. However, prototypes always have a chance of generating [the magic smoke](https://en.wikipedia.org/wiki/Magic_smoke), so it's nice to be able to limit the current to avoid that fate. In addition to that, I already have a [fancy soldering iron that is power by USB-C](https://smile.amazon.co.uk/SainSmart-Upgraded-Soldering-Adjustable-Temperature/dp/B07FY658LN/), so why not a cordless power supply powered by USB-C too? Below you can see the result from my weekend tinkering :sweat_smile:.

<figure>
  <img src="{{ site.url }}/public/images/power_supply_with_powerbank.jpg?style=centerme" alt="variable-power-supply">
  <figcaption>Digital Variable Power Supply, with Current limitation, powered by a USB-C power bank.</figcaption>
</figure>

<!--more-->

The idea of using USB-C as a variable power supply is not new. When I had this idea, some time ago, my first google excursion already was showing [videos on youtube](https://www.youtube.com/watch?v=aIHj3qMRqqE). For the 3D model was not different, and I used [this model](https://www.thingiverse.com/thing:2429908) to get the dimensions of the window for the digital power supply. So, my variable power supply is nothing more than an [LCD Digital Programmable Constant Voltage Current Step-down Power Supply Module](https://smile.amazon.co.uk/gp/product/B01I9LQIU2/), a [ZY12PDN](https://smile.amazon.co.uk/gp/product/B08FD6381L/), two [banana sockets](https://smile.amazon.co.uk/gp/product/B08CZFTP3F/) and some 3D printed parts designed using [FreeCAD](../extras/VariablePowerSupply.FCStd). I already had the [USB-C PD power bank](https://smile.amazon.co.uk/Charmast-10000mAh-Portable-Flashlight-Compatible/dp/B07Y231M28/).

At the end, the result was rather nice and I'm posting it here because I think someone else may want to build one as well (**as always, do it at your own risk, of course**) :sweat_smile:.

<figure>
  <img src="{{ site.url }}/public/images/power_supply_back.jpg?style=centerme" alt="variable-power-supply-back">
  <figcaption>Unreasonably gigantic banana sockets that could carry enough current to melt the USB-C connector.</figcaption>
</figure>

It took around 3 hours to bring both parts (I printed them individually to avoid [stringing](https://help.prusa3d.com/en/article/stringing-and-oozing_1805/)). I used a part modifier to make the infill at the USB-C connector of a higher density.
<figure>
  <img src="{{ site.url }}/public/images/power_supply_3d_print.png?style=centerme" alt="variable-power-supply-3d-parts">
  <figcaption>3D parts after slicing.</figcaption>
</figure>

I used [PrusaSlicer](https://github.com/prusa3d/PrusaSlicer) to slice the parts because I like to use the part modifiers. Here are the files:  
  * [FreeCAD file](../extras/VariablePowerSupply.FCStd) (I'm still learning how to use it, so don't judge me...)
  * [3D AMF file for the case](VariablePowerSupply-Case.amf)
  * [3D AMF file for the lid](VariablePowerSupply-Lid.amf)
  * [PrusaSlicer project file](VariablePowerSupply-Lid.3mf) ([you can check how to use the part modifiers in this video](https://www.youtube.com/watch?v=6PVeh43Or-g))

**Note - 1:**  
All the links to [smile.amazon.co.uk](https://smile.amazon.co.uk/gp/chpf/about/ref=smi_aas_redirect) are there because _AmazonSmile is a simple and automatic way for you to support a charity of your choice every time you shop, at no cost to you._ You can search online for the names and you will find them somewhere else.

**Note - 2:**  
Have I already mentioned that I take no responsibilities if you put the world on fire trying to build your own? :sweat_smile: