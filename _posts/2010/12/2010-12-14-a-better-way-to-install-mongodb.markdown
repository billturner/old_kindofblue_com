---
layout: post
date: 2010-12-14T18:10:00-05:00
title: A better way to install MongoDB on Ubuntu
description: An update to the other instructions here on the site
tags:
- mongodb
- ubuntu
---
My [last post on installing MongoDB on Ubuntu](http://kindofblue.com/2010/01/installing-mongodb-on-ubuntu/ "My previous MongoDB on Ubuntu archive post") is quite popular. Sadly, they aren't the best, or the most up to date installation instructions. While I don't really mess with MongoDB anymore, I feel a little bad with so much traffic coming from Google to those outdated instructions. In fact, it's super easy to install MongoDB on an Ubuntu server these days.

Basically, all you need to do is add a new source to your `/etc/apt/sources.list`. For the latest Ubuntu (10.10 at the time of this post), you'll add:

    deb http://downloads.mongodb.org/distros/ubuntu 10.10 10gen

Once you've added the new source, you'll need to import MongoDB's public GPG key in order to download from the official servers:

    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10

Once that's done, run `sudo apt-get update` and then `sudo apt-get install mongodb-stable` to get the latest stable release. Once installed, you can configure via the configuration file at `/etc/mongodb.conf`.

The full instructions, including the source URLs for older Ubuntu/Debian versions, can be found on [the MongoDB website](http://www.mongodb.org/display/DOCS/Ubuntu+and+Debian+packages "Ubuntu and Debian package instructions on the MongoDB website").

_Edited 12/15/2010: Added the GPG key step._
