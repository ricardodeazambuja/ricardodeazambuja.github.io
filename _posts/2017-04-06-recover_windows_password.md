---
layout: post
title: How to reset your Windows 7, 8 or 10 password without black magic
category: windows
draft: false
published: true
comments: true
---

Currently, I'm a last year Robotics / Artificial Intelligence Ph.D candidate (don't be shy, have a look at my [publications]({{ site.url }}/publications/)), father of a 7-yrs-old boy and I'm living abroad with my family since 2013. So, life is quite busy, a little bit stressful and it happens that, sometimes, I simply forget things. The other day, I was setting up a new Dell laptop (I've bought it really, really cheap from their UK outlet, free delivery and I even got an extra student discount!) that came with [Windows 10](https://en.wikipedia.org/wiki/Windows_10) and, as always, I created a very hard to guess password. It was so hard to guess that I forgot it after a week! And that's how the idea for this post began.

<figure>
  <img src="{{ site.url }}/public/images/why_cant_sign_in.png?style=centerme" alt="How to recover your windows password">
  <figcaption>This webpage was not helpful in my situation.</figcaption>
</figure>

<!--more-->

As I already said, I had this problem with a laptop running Windows 10 and, although I consider my [google-fu](https://en.wiktionary.org/wiki/Google-fu) *strong*, I could only find a lot of instructions that didn't work for me because I didn't have the recovery disk and [my Windows was not connected to my Microsoft account](https://answers.microsoft.com/en-us/insider/wiki/insider_wintp-insider_security/how-to-connect-to-a-microsoft-account-in-windows/c1614fe6-a9cd-4723-a9e0-7293d9cdfd4a) yet. You know, I thought I would never forget a password :innocent:. Finally, [HTG](https://www.howtogeek.com/222262/how-to-reset-your-forgotten-password-in-windows-10/) seemed to have the answer, yet I was missing a small detail (I didn't know what was the *Utility Manager* to click on it) and that was only clarified after reading the [PC World](http://www.pcworld.com/article/2988539/windows/if-you-forget-your-windows-admin-password-try-this.html) hint saying to click on the easy-access icon.

<figure>
  <img src="{{ site.url }}/public/images/ease_access_icon.png?style=centerme" alt="This is the easy-access icon">
  <figcaption>If you don't know it as well, this is the easy-access icon (<a href="http://www.softicons.com/system-icons/windows-8-metro-invert-icons-by-dakirby309/folder-ease-of-access-icon">source</a>).</figcaption>
</figure>

To avoid having to look somewhere else, I will write here the steps I took to get back to my Windows 10 (and it should work for Windows 7 and 8 too)!

## Step 1
First, you will need to create a bootable Windows installer DVD / USB stick. If you are lucky enough to have a Windows DVD, since most computers, nowadays, come simply with a pre-installed version instead of a physical media, and even luckier to have a DVD drive, you can just boot from your DVD, so I suggest you to jump straight into **Step 2**.

However, most of us don't have the media or a DVD drive. Microsoft seems to know that and they provide a special webpage called [Windows USB/DVD Download Tool](https://www.microsoft.com/en-gb/download/windows-usb-dvd-download-tool) where you can download it. Actually, the [*new* Microsoft](https://www.theregister.co.uk/2016/05/06/thoughts_on_the_new_microsoft/) also provides a [special page](https://www.microsoft.com/en-gb/software-download/windows10ISO) for people running something else but Windows.

If your computer has a DVD drive, but you don't have the Windows install DVD, you can download the ISO from Microsoft and find a place to record a DVD. You will need a second computer with a DVD recorder, anyway.

The USB stick option should work for almost everybody, but it can be a little bit tricky if you don't have a second computer with Windows installed (if you have, the [Windows USB/DVD Download Tool](https://www.microsoft.com/en-gb/download/windows-usb-dvd-download-tool) will do the job for you). Even if you have a spare Windows system running from virtual machine like me (Parallels 12 in my case), the program available from the Windows USB/DVD Download Tool (MediaCreationTool.exe) may not find your USB drive (that was what happened to me, even though Parallels could access and see the it). In this situation, you will need to use the ISO file, instead.

Since I was using a Macbook Pro running [OSX Yosemite](https://en.wikipedia.org/wiki/OS_X_Yosemite), I just launched the [Boot Camp Assistant](https://support.apple.com/en-gb/boot-camp) and asked it to create a Windows install disk (in fact, it was a USB stick) using a previously generated ISO file. It worked like a charm :relieved:.

If you are using Linux, one of these links ([link1](http://askubuntu.com/questions/289559/how-can-i-create-a-windows-bootable-usb-stick-using-ubuntu) and [link2](https://thornelabs.net/2013/06/10/create-a-bootable-windows-7-usb-drive-in-linux.html)) may work for you.

## Step 2
Ok, with your Windows Installer DVD or USB stick ready to rock, you need to find a way to [boot](https://en.wikipedia.org/wiki/Booting) your computer from it. Normally, you just need to connect it, switch on the computer and it will find the DVD/USB stick and boot from it. However, [Murphy's law](https://en.wikipedia.org/wiki/Murphy%27s_law) is a powerful one and if your computer is not configured to first try to boot from the DVD/USB, you may have problems. The solution is to find out how to access the BIOS configurations to change the boot order or find a special key that lets your select the boot order. The laptop I was trying to recover was a Dell, so I just had to push the F12 key to select the boot from a USB stick.

After booting from the Windows Installer DVD/USB, you will need a command prompt. One problem with the [HTG instructions](https://www.howtogeek.com/222262/how-to-reset-your-forgotten-password-in-windows-10/) was they say you should press `SHIFT+F10`, but it was not working for me. It took me a while to find a solution because on my laptop you need to press the FN key to activate the *F-keys* making it `SHIFT+FN+F10`.

With the command prompt available, the *magic* is done by altering the `Utilman.exe` file. First, we need to find where Windows is installed. Try a simple `dir C:\Windows\System32` and, if it worked, go ahead and make a backup of `Utilman.exe` using:

```
move C:\Windows\System32\Utilman.exe C:\Windows\System32\Utilman.exe.old
```

After that, we want to trick Windows to launch `cmd.exe` instead of `Utilman.exe`. This is accomplished by:

```
copy C:\Windows\System32\cmd.exe C:\Windows\System32\Utilman.exe
```

Now, you can just type:

```
wpeutil reboot
```

Remove your USB stick after the screen becomes black and wait for Windows to boot again.

Since we replaced `Utilman.exe` with `cmd.exe`, you need to click on the easy-access icon and it will launch a [command prompt](https://www.lifewire.com/command-prompt-2625840) now (I learned this from [PC World](http://www.pcworld.com/article/2988539/windows/if-you-forget-your-windows-admin-password-try-this.html)).


After all that, with your command prompt available, type:

```
net user
```

find your user name and type (pay attention, you must add a space and the asterisk at the end just after the user name):

```
net user YOUR_USER_NAME_HERE *
```

Change your password and that's it! At least it worked for me :bowtie:.

**Attention:** don't forget to *UNDO* what you have done to `Utilman.exe` by copying the backup version back to its old name:

```
move C:\Windows\System32\Utilman.exe.old C:\Windows\System32\Utilman.exe
```

I hope these instruction will be useful to someone else, cheers!
