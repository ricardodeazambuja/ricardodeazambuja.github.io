---
layout: post
title: Creating Singularity containers from local Docker images
category: docker
draft: true
published: true
comments: true
date: 2019-11-13 10:00:00
---

TL; DR: Singularity containers are like Docker containers that don't force you to be root to run them. Ok, if you want a better explanation, I suggest [this presentation](http://www.hpcadvisorycouncil.com/events/2017/stanford-workshop/pdf/GMKurtzer_Singularity_Keynote_Tuesday_02072017.pdf) or just [try searching for it](https://lmgtfy.com/?q=what+are+singularity+containers&s=g).  

I'm writing this post to keep this info easily accessible for me and my ~4 readers... An aspect I like about Singularity is the possibility of reusing a Docker image. However, afaik it only works if the image is available on [Docker Hub](https://hub.docker.com/) or another place that allows you to pull the image. The problem I encounter was that I didn't want to push my image to Docker Hub. I found a possible solution [online](https://stackoverflow.com/a/52739204). Moreover, I wanted to use the latest version of Singularity (at the time I wrote this tutorial [it was the 3.4](https://sylabs.io/guides/3.4/user-guide/index.html)) and by default Ubuntu was installing the 2.X. So, to install the latest version you can check directly [here]($ wget -O singularity-container.deb http://http.us.debian.org/debian/pool/main/s/singularity-container/) and choose what you want. This is how I did it:

```
$ wget -O singularity-container.deb http://http.us.debian.org/debian/pool/main/s/singularity-container/singularity-container_3.4.2%2Bds2-4_amd64.deb
$ sudo dpkg -i singularity-container.deb
$ sudo apt-get install -f
$ rm singularity-container.deb
```

I had a Docker image that was created earlier (`my_docker_image`) and this was my Singularity recipe called `singularity_recipe.txt` ([I suppose, officially it's called definition file](https://sylabs.io/guides/3.4/user-guide/definition_files.html)):

```
Bootstrap: docker
From: my_docker_image:latest
Registry: localhost:5000
```

However, before it's possible to create a Singularity image it's necessary to launch the local registry and push the docker image (`my_docker_image`) there.

```
$ docker run -d -p 5000:5000 --restart=always --name registry registry:2
$ docker push localhost:5000/my_docker_image:latest
```

Here is one caveat about Singularity: **it DOES need root to create images** (although a normal user can later use the image). 


The command to create the imageis:

```
$ sudo SINGULARITY_NOHTTPS=true singularity build singularity.simg singularity_recipe.txt
```

Or if your recipe is as simple as mine (there's nothing but the Docker image), it's possible to avoid that file and use instead:

```
$ sudo SINGULARITY_NOHTTPS=true singularity build singularity.simg docker://localhost:5000/my_docker_image:latest
```

Now that the Singularity image is ready, there are many ways to use it. Here are some examples:

Accessing the local GPU(s) (the `--nv ` argument is responsible for the magic) and executing something available inside the image:
```
$ singularity exec --nv singularity.simg python3 /directory_inside_the_image/my_test_script.py
```

Instead of executing something, it is also possible to open a shell:
```
$ singularity shell --nv singularity.simg
```

Mounting something inside the image:
```
$ singularity shell -B /some_directory_on_host:/location_on_the_image --nv singularity.simg
```

One problem I found with Singularity using the commands above was the way it launches processes. If you launch many processes and closes the shell (or the command if using exec), it will not kill the child processes. To avoid such a mess it is necessary to create an instance:
```
$ singularity instance start --nv singularity.simg mysessionname
$ singularity exec instance://mysessionname something_I_want_to_execute
$ singularity instance stop mysessionname
```

Singularity gives the option of creating a sandbox image that is actually a directory:
```
$ sudo SINGULARITY_NOHTTPS=true singularity build -s singularity_directory docker://localhost:5000/my_docker_image:latest
```
or it's possible to create a sandbox directory from an image:
```
$ sudo singularity -s singularity_directory singularity.simg 
```

Using such sandbox it's possible navigate inside the image without using singularity at all or to change the image (normally the image contents are read-only) using the `--writable` argument and sudo:
```
$ sudo singularity shell --writable singularity_directory
```

There's also the `--writable-tmpfs` if you want to write to the image, but doesn't want it to save anything.


**This is quite important:** [Singularity will by default mount](https://sylabs.io/guides/3.0/user-guide/bind_paths_and_mounts.html) the directories $HOME , /tmp , /proc , /sys , /dev, and $PWD... **TOGETHER** with whatever is inside the image. E.g.: if the image has `/home/some_user` and your local home is `/home/user_host`, the container will see both `some_user` and `user_host` under `/home`.  It's weird and dangerous because if you use something like `rm -rf /home`, it will destroy everything while using Docker you would need to tell it to mount your stuff.



Finally, you probably want to close and remove the container running the local Docker registry:
```
$ docker stop registry
$ docker rm registry
```

Since I'm far from an expert on Singularity, I will end this post by leaving the link to [Singularity User Guide](https://sylabs.io/guides/3.4/user-guide/index.html) here, just in case someone still wants to know more.