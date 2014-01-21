---
layout: post
date: 2010-02-11T13:34:03-0500
title: Updated my s3 backup script to support MongoDB
description: Since I started playing with MongoDB, I wanted my backup script to include them in the backups.
tags:
- mongodb
- ruby
- system administration
---
Given [my recent interest](http://kindofblue.com/2010/01/installing-mongodb-on-ubuntu "My recent post on installing MongoDB") in [MongoDB](http://mongodb.org/ "The MongoDB home page"), I figured I should update [my Ruby backup script](http://brilliantcorners.org/2009/12/a-simple-ruby-script-for-backing-up-files-to-amazon-s3 "My previous entry on the simple-s3-backup.rb script") to now support the exporting and backing up of MongoDB databases.

I've updated the code and placed the changes up in [my Github account](http://github.com/billturner/ "My main Github account page"): [simple-s3-backup](http://github.com/billturner/simple-s3-backup "A direct link to the 'simple-s3-backup' repository on Github").
