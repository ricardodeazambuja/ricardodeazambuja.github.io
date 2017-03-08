---
layout: post
title: Running a Jupyter Notebook (IPython) on a remote server
category: jupyter_notebooks
draft: false
published: true
comments: true
---

Do you know what is a [Jupyter Notebook](http://jupyter.org/)? If you don't, please, have a look at the previous link and come back later... just joking... ok, seriously, check the previous link because they will do a much better job explaining what is a Jupyter Notebook than me :wink:.

<figure>
  <img src="{{ site.url }}/public/images/jupyter_notebook.jpg?style=centerme" alt="jupyter notebook">
  <figcaption>This is what I was doing just before start writing this post.</figcaption>
</figure>

<!--more-->

Why do I love those notebooks? Probably it's started long time ago while I still was a [Mathematica](https://www.wolfram.com/mathematica/), [Maple](http://www.maplesoft.com/products/maple/) and [MuPad](https://uk.mathworks.com/discovery/mupad.html) user, but I would say I like notebooks mainly because I can keep, in one place, code, comments (pure text, [Markdown](http://jupyter-notebook.readthedocs.io/en/latest/examples/Notebook/Working%20With%20Markdown%20Cells.html), [HTML](https://blog.dominodatalab.com/lesser-known-ways-of-using-notebooks/), [LaTeX](http://jupyter-notebook.readthedocs.io/en/latest/examples/Notebook/Typesetting%20Equations.html), [animations](http://louistiao.me/posts/notebooks/embedding-matplotlib-animations-in-jupyter-notebooks/), [external images/videos](http://nbviewer.jupyter.org/github/ipython/ipython/blob/1.x/examples/notebooks/Part%205%20-%20Rich%20Display%20System.ipynb#Video), etc) and, the most important, results. I can also easily share things by exporting a notebook as HTML or PDF or uploading it to a place where there's a notebook viewer (you can see an example [here](https://github.com/ricardodeazambuja/keras-adventures/blob/master/Dogs_vs_Cats/Keras%20Cats%20and%20Dogs%20-%20normal%20deep%20net%20(not%20so%20deep).ipynb)). I've never tested Jupyter with other languages but Python, so I will tell you about my experiences using Python. In the past, Jupyter notebooks used to be called IPython notebooks, therefore it was Python only. However, currently it supports more than 40 programming languages including [Python](https://ipython.org/notebook.html), [R](https://irkernel.github.io/), [Julia](https://github.com/JuliaLang/IJulia.jl), [Ruby](https://github.com/SciRuby/iruby) and [Scala](https://www.scala-lang.org/) (this is the first time I've read about Scala...).

Ok, let's make a list of the things we want to learn here:

- [ ] Launch a Jupyter Notebook server without automatically opening a browser.
- [ ] Create a SSH tunnel to redirect a local port to the server.
- [ ] Access your remote server from your browser.

Jupyter is capable to serve, just like a [web server](https://en.wikipedia.org/wiki/Web_server), notebooks directly to any browser. They give you full instructions [here](http://jupyter-notebook.readthedocs.io/en/latest/public_server.html). The problem with that solution, in my opinion, is the complexity. If you just carelessly open things, you are going to expose your server :scream:.

To launch the Jupyter Notebook server (on the remote computer) and keep it running after we logout, we will need help from our friend [`nohup`](https://en.wikipedia.org/wiki/Nohup). Nohup allows us to logout without killing the processes our terminal started and the ampersand (`&`) sends `nohup` to the background *freeing* the terminal (in case you want to do something else after launching it...). The [command](http://stackoverflow.com/a/31953548) to launch the notebook without also launching the web browser (even if you are accessing it remotely through `ssh` using the `-X` option to redirect the display, it would be a waste of resources and time):

```
$ nohup jupyter notebook --no-browser &
```
<div class="message">
  Caveat: You will only be able to access files (and subdirs) located on the current directory.
</div>

After that, you can disconnect from the remote computer, open a terminal on the client computer and type this (more details about the *[ssh](https://linux.die.net/man/1/ssh) tunneling magic* can be found [here](http://blog.trackets.com/2014/05/17/ssh-tunnel-local-and-remote-port-forwarding-explained-with-examples.html)):

```
$ ssh -nNT -L 9999:localhost:8888 user@example.com
```
The command line above has only two things you surely must change: `user` is the username at the remote computer and `example.com` will probably be replaced by the remote computer's IP address. Now we have created a tunnel that will redirect the [port](https://en.wikipedia.org/wiki/Port_(computer_networking)) 9999 to the remote server port 8888 (this is the default used by Jupyter). I'm using the port number 9999 because, usually, I also have a local Jupyter Notebook server running at 8888.

The only thing you need to do now is launch your browser and access the url ~~`localhost:8888`~~ `localhost:9999` and done, you have got a remote Jupyter Notebook working!

Recalling the list at the beginning of this post:

- [x] Launch a Jupyter Notebook server without automatically opening a browser.
- [x] Create a SSH tunnel to redirect a local port to the server.
- [x] Access your remote server from your browser.

**Addendum (05/03/2017):**

If you execute the command:

```
$ ssh -nNT -L 9999:localhost:8888 user@example.com
```

You will be capable to access the port 8888 from `example.com`, on your local machine, using `localhost:9999`. However, if you want to allow other machines to easily access that port too, it will not be possible. I had this problem last week when I was trying to show some contents on [Pepper's](https://www.ald.softbankrobotics.com/en/cool-robots/pepper) tablet through [a very simple Python web server](https://docs.python.org/2/library/simplehttpserver.html) hosted on a virtual machine. My team from [NAO Hackathon](https://github.com/ricardodeazambuja/Hackathon-Plymouth-2017) was in a hurry and I could not make the redirection work (I should have read the [manual](https://linux.die.net/man/1/ssh):disappointed:). Ok, so there are at least three possible solutions. The first one will work if your computer (the client here) has only one network address:

```
$ ssh -nNT -L :9999:localhost:8888 user@example.com
```

If your computer has more than one network adapter, you can *bind* an IP (forcing the tunnel only through the bound IP) using this command (the second possible solution):

```
$ ssh -nNT -L ip_you_want_to_bind:9999:localhost:8888 user@example.com
```

The third possibility (*SSH-BASED VIRTUAL PRIVATE NETWORKS*) can be found on the [ssh manual webpage](https://linux.die.net/man/1/ssh) (or, in case you want a more straightforward link, [here](http://superuser.com/a/311863)) and it involves more than one command line (the `-f` argument only sends ssh to background) and you will need to mess with `ifconfig` and `route`. I'm not sure if `route` works the same on all Unix flavours, but apparently it [does](https://en.wikipedia.org/wiki/Route_(command)). I think this last solution is a more robust one when the connection is supposed to be perpetual instead of something to run during some minutes only.

Cheers!
