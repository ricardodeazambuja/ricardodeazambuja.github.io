---
layout: post
title: My Old Projects or Why You Should Document and Share Your Stuff Online
category: projects
---

Today, I've decided to write something to make sure I'm not going to forget, again, about my old projects. Another reason for this post is to be an incentive for sharing / publishing your work online. If I had published everything online, as I was developing, I would not need to write a post about things from the past like I'm doing right now ;)  

When I was still an undergrad student (2000-2005), mobile phones with good quality cameras were not available and only in 2004 (or 2005?) I got one with a really noisy, probably VGA, camera.  I was only able to have such a phone because I found an unsolvable bug on my old one, while still on guarantee, and they had no choice but give me a better one (Brazil has some really nice consumer protection laws). Also, Dropbox, GoogleDrive, etc were not available and it was quite common to lose data from time to time after a problem with a hard drive.

During my years as an undergrad Electrical Engineering student, I've developed some interesting projects, but most of them I've not saved any picture, schematic, etc. For one of my analog electronics modules, my group designed a circuit to multiply two input signals using only transistors. I still remember that Analog Devices had one IC that could do exactly what we struggled to build for that module. The control systems module demanded us to develop an analog PID controller and I implemented a controller for CPU fans. Later on, I've worked on a Neural Network implementation using FPGA that should be able to recognise simple numbers. All those projects are lost, since I don't have backup of anything or photos. My first project to have a digital picture saved was during the microcontrollers module. My group designed a home automation system, based on 8051, where you could activate relays through DTMF. Here is the picture (we recycled my old 56K USRobotics faxmodem plastic enclosure):  
<figure>
  <img src="{{ site.url }}/public/images/DARVIT_2.jpg?style=centerme" alt="DARVIT">
  <figcaption>DARVIT - 8051 based home automation system.</figcaption>
</figure>

<!--more-->

Luckily, my final project was preserved (thanks to the aforementioned noisy mobile camera and better backup systems) and I've managed to upload it to github too ([TEXVID](https://github.com/ricardodeazambuja/TEXvid)). It was based on the Microchip PIC16F and entirely written in Assembly! It was a very simple system capable of showing messages using a TV with composite video input.  
<figure>
  <img src="{{ site.url }}/public/images/texvid_working.jpeg?style=centerme" alt="TEXVID">
  <figcaption>TEXvid - Message Generator for Composite Video based on PIC16F.</figcaption>
</figure>

So, around the time I was finishing my first degree, I had this idea of building my own hobby CNC router. It was not an easy task in Brazil at that time (2006?) because, sometimes, we could not find the most basic parts (with a reasonable price). Also, I had just got married, moved to a new house and I didn't have proper tools. This time I had a camera, but I didn't have time to properly document it and I thought I would do it when I had a better design, etc. This first machine was built using drawer slides, since I could not afford real ball bearing guides. The only picture I have is this one:  
<figure>
  <img src="{{ site.url }}/public/images/MyFirstRouter.jpg?style=centerme" alt="Poor guys MDF CNC Router">
  <figcaption>My first attempt to build a CNC router.</figcaption>
</figure>

Because it was quite hard to build things that would need to be parallel, I started looking for another design paradigm. The inspiration came from an old Elektor magazine where they presented a [CNC machine using polar coordinates](https://youtu.be/K7yomRmN52Q). That seemed perfect, because it would be easier to build my router using the tools I had available. However, the Elektor version had some caveats: it was necessary some gears to increase the resolution. Since I didn't have any gearbox, I developed a simple microstep driver (again using the PIC16F) to increase the resolution. I had a digital camera, but because my life was very busy and I was moving again to a new place, I saved only this picture:  
<figure>
  <img src="{{ site.url }}/public/images/MyRadialRouter.jpg?style=centerme" alt="My polar or radial router">
  <figcaption>My polar or radial router: it was supposed to become, one day, a PCB engraver.</figcaption>
</figure>

After I graduated (January 2006), I started working full time in my family's engineering company. The company doesn't exist anymore, but I still keep the old website online ([Azamec.com](http://azamec.com)). Actually, I started working with my father when I was a lot younger than that. My father was not a big fan of computers, so he would always buy the computers and teach me how to use them - this way I was his computer operator. I loved that because I always had cool computers (and I could also use them for games!). Here are some videos of the equipments we produced:  

<div class="video-container" align="center">
<iframe width="560" height="315" src="https://www.youtube.com/embed/UOWg353JbDk" frameborder="0" allowfullscreen></iframe>
</div>
<br />

<div class="video-container" align="center">
<iframe width="560" height="315" src="https://www.youtube.com/embed/UQGq369V3AI" frameborder="0" allowfullscreen></iframe>
</div>
<br />

<div class="video-container" align="center">
<iframe width="560" height="315" src="https://www.youtube.com/embed/Wz_oYNcNnos" frameborder="0" allowfullscreen></iframe>
</div>
<br />

<div class="video-container" align="center">
<iframe width="560" height="315" src="https://www.youtube.com/embed/oHGCXv1XYxI" frameborder="0" allowfullscreen></iframe>
</div>
<br />


In 2011, I started my Master's degree in Electrical Engineering / Automation. At the beginning, I was planing to do my dissertation on non-destructive testing (NDT) based on [Barkhausen effect](https://en.wikipedia.org/wiki/Barkhausen_effect). I developed quite a few things including special sensor coils and a super-high-gain-and-low-noise amplifier. However, lack of equipments and "destiny" forced me to change from Barkhausen noise to [wireless power transmission](http://ricardodeazambuja.com/publications/). And, one more time, I did not save pictures or the schematics from most of the things I developed. In fact, from my master's I have the papers and very few photographs. It was a two years degree where the first year was dedicated to attend modules from the graduate school. I attended Linear Systems, Optimization, Stochastic Processes, Instrumentation, Design of Experiments and Advanced DSP. For Optimization, we manually developed a lot of algorithms in Matlab (and I have nothing saved). Design of Experiments had a initial part on Monte Carlo methods and a second one on the design of experiments itself (yep, nothing saved again!). Stochastic Processes, Advanced DSP and Linear Systems were more traditional modules, however we developed quite a few things in Matlab, but I don't have a line of code saved. The only pictures I could find after asking a lot of different things to my Gmail account were the ones from a special shaker we developed using an unbalanced motor and one from my workbench while I was executing the experiments for my master's thesis.
<figure>
  <img src="{{ site.url }}/public/images/shaker_1.png?style=centerme" alt="My polar or radial router">
  <figcaption>Shaker - it was strong and big enough that a person could hop on!</figcaption>
</figure>

<figure>
  <img src="{{ site.url }}/public/images/shaker_2.png?style=centerme" alt="My polar or radial router">
  <figcaption>Shaker - details of the eccentric load attached to a DC motor to vary the frequency of oscillation.</figcaption>
</figure>

<figure>
  <img src="{{ site.url }}/public/images/shaker_3.png?style=centerme" alt="My polar or radial router">
  <figcaption>Shaker - Springs.</figcaption>
</figure>

<figure>
  <img src="{{ site.url }}/public/images/ExperimentoBancada.jpg?style=centerme" alt="My polar or radial router">
  <figcaption>My workbench, at home, during the final stage of my Master's degree.</figcaption>
</figure>

I've only really learned about sharing and publishing things online during my Ph.D, but not at the first year! I don't know why, but I had this silly feeling that I should not publish my work online. I only managed to learn when I finished the first version of my [Spiking Neural Network simulator](https://github.com/ricardodeazambuja/BEE) and started using Github. Now, I really don't care if it is unfinished, badly documented or it's simply not such a great piece of code, I publish everything online as soon as possible :smiley:  
