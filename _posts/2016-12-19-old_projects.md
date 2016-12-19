---
layout: post
title: My Old Projects
category: projects
---

Today I've decided to write something to make sure I'm not going to forget, again, about my old projects. When I was still an undergrad student (2000-2005), mobile phones with good quality cameras were not available and only in 2004 (or 2005?) I got one with a really noisy, probably VGA, camera.  I was only able to have such a phone because I found an unsolvable bug on my old one, while still on guarantee, and they had no choice but give me a better one (Brazil has some really nice consumer protection laws). Also, Dropbox, GoogleDrive, etc were not available and it was quite common to lose data from time to time after a problem with a hard drive. 

During my years as an undergrad Electrical Enginnering student, I've developed some interesting projects, but most of them I've not saved any picture, schematic, etc. For one of my analog electronics modules, my group designed a circuit to multiply two input signals using only transistors. I still remember that Analog Devices had one IC that could do exactly what we strugled to build for that module. The control systems module demanded us to develop an analog PID controller and I implemented a controller for CPU fans. Later on, I've worked on a Neural Network implementation using FPGA that should be able to recognise simple numbers. All those projects are lost, since I don't have backup of anything or photos. My first project to have a digital picture saved was during the microcontrollers module. My group designed a home automation system, based on 8051, where you could activate relays through DTMF. Here is the picture (we recycled my old 56K USRobotics faxmodem plastic enclosure):  
![DARVIT]({{ site.url }}/public/DARVIT_2.jpg)  

Luckly, my final project was preserved (thanks to the aforehead noisy mobile camera and better backup systems) and I've managed to upload it to github too ([TEXVID](https://github.com/ricardodeazambuja/TEXvid)). It was based on the Microchip PIC16F and entirely written in Assembly! It was a very simple system capable of showing messages using a TV with composite video input.
![TEXVID]({{ site.url }}/public/texvid_working.jpeg	)  

After I graduated (January 2006), I started working full time in my family's engineering company. The company doesn't exist anymore, but I still keep the old website online ([Azamec.com](http://azamec.com)). Actually, I started working with my father when I was a lot younger than that. My father was not a big fan of computers, so he would always buy the computers and teach me how to use them - this way I was his computer operator. I loved that because I would always have cool computers (and I could also use them for games!). Here are some videos of the equipments we produced:  
<iframe src="https://drive.google.com/file/d/0B9eAOG1w01sNZGhrbnFjMFFKUlE/preview" width="640" height="480"></iframe>  
<iframe src="https://drive.google.com/file/d/0B9eAOG1w01sNNHl1V2RzYUt0RVE/preview" width="640" height="480"></iframe>  
<iframe src="https://drive.google.com/file/d/0B9eAOG1w01sNVlhUSzhET1E3SU0/preview" width="640" height="480"></iframe>  

So, around the time I was finishing my first degree, I had this idea of building my own hobby CNC router. It was not an easy task in Brazil at that time (2006) because, sometimes, we could not find the most basic parts (with a reasonable price). Also, I had just got married and moved to a new house and I didn't have proper tools. This time I had a camera, but I didn't have time to properly document it and I thought I would do it when I had a better design, etc. This first machine was built using drawer slides, since I could not afford real ball bearing guides. The only picture I have is this one:  
![My first temptative for CNC router]({{ site.url }}/public/MyFirstRouter.jpg)

Because it was quite hard to build things that would need to be parallel, I started looking for another design paradigm. The inspiration came from an old Elektor magazine where they presented a CNC machine using polar coordinates. That seemed perfect, because it would be easier to build my router using the tools I had available. However, the Elektor version had some caveats: it was necessary some gears to increase the resolution. Since I didn't have any gearbox, I developed a simple microstep driver (again using the PIC16F) to increase the resolution. I had a digital camera, but because my life was very busy and I was moving again to a new place, I saved only this picture:
![My polar or radial router]({{ site.url }}/public/MyRadialRouter.jpg)
