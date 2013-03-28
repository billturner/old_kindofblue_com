---
layout: post
date: 2010-01-31T20:34:51-05:00
title: Installing MongoDB on Ubuntu
description: A now-outdated list of instructions to build MongoDB on an Ubuntu system.
tags:
- mongodb
- ubuntu
---
**EDIT: Please take a look at [some updated instructions](http://brilliantcorners.org/2010/12/a-better-way-to-install-mongodb "A new post on installing MongoDB on Ubuntu"). The information here is a bit out of date, and makes things a _lot_ harder than it needs to be.**

There are already a few installation tutorials for getting [MongoDB](http://www.mongodb.org/ "The MongoDB home page") up and running on an Ubuntu server, but each either left a step or two out, or their suggested setup wasn't what I was looking for, so I'm sharing my own tips. But, a few notes first:

1. These instructions are how I installed MongoDB on Ubuntu 8.10 (Intrepid Ibex)
2. Many of the tutorials out there recommend putting MongoDB in `/opt/mongodb`, but I chose `/usr/local` instead
3. These instructions worked for me, and they probably will for you, but I can't guarantee a thing

**Initial user and directory setup**

Before installing anything, I'm going to prepare some necessary directories and create the mongodb user:

    sudo adduser mongodb
    # for the mongodb data files:
    sudo mkdir /var/lib/mongodb
    # for the log files:
    sudo mkdir /var/log/mongodb
    sudo chown mongodb /var/lib/mongodb/

**Install dependencies**

Install the needed dependencies for building MongoDB from source:

    sudo apt-get install curl tcsh scons g++ xulrunner-1.9-dev libpcre++-dev libboost-dev libmozjs-dev

Now, the Mozilla JavaScript libary. I normally install from my own temp directory (`~/tmp`), but download and compile from wherever you're comfortable:

    curl -O ftp://ftp.mozilla.org/pub/mozilla.org/js/js-1.7.0.tar.gz
    tar zxvf js-1.7.0.tar.gz
    cd js/src
    export CFLAGS="-DJS_C_STRINGS_ARE_UTF8"
    make -f Makefile.ref
    sudo JS_DIST=/usr make -f Makefile.ref export

**Build MongoDB**

We'll use `git` to clone the source from [their GitHub repository](http://github.com/mongodb/mongo "The MongoDB source tree at GitHub.com"). I'm also going to compile the 1.2.2 release instead of the current HEAD. Again, get the source and build from whichever temp directory you're comfortable with.

    git clone git://github.com/mongodb/mongo.git
    cd mongo
    # checkout the 1.2.2 release for building
    git checkout -b build r1.2.2
    # build:
    scons all
    # install:
    sudo scons --prefix=/usr/local install


Now, create the `init.d` script file to have MongoDB start up on a reboot.

    sudo vi /etc/init.d/MongoDB
    # my version of this script is here: http://gist.github.com/291349
    # make init script executable:
    sudo chmod +x /etc/init.d/MongoDB
    # set up runtime links:
    sudo update-rc.d MongoDB defaults

And to get it up and running, just run the init script:

    sudo /etc/init.d/MongoDB start

If all the steps above went without any problems, then MongoDB should now be up and running on your Ubuntu server.

Here are some references that helped a lot in getting my own setup working:

* [Installing MongoDB on Ubuntu 9.04 Jaunty Jackalope](http://tech.favoritemedium.com/2009/08/installing-mongodb-on-ubuntu-904-jaunty.html "This tutorial came the closest to getting me where I wanted")
* [MongoDB docs: Building for Linux](http://www.mongodb.org/display/DOCS/Building+for+Linux "This also helped, but missed alot")

Now, what I'm _using_ MongoDB for will have to wait a day or so. :)
