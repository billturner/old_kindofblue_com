---
layout: post
date: 2009-12-14T21:22:20-05:00
title: A simple Ruby script for backing up files to Amazon S3
excerpt: I wrote a simple Ruby script to back up many types of files to an Amazon S3 buckets.
tags:
- ruby
- system administration
---
After reading about [the troubles Jeff Atwood had with his host going down](http://news.ycombinator.com/item?id=990323 "Hacker News post on Jeff Atwood's 100% data loss"), I figured it was time I get a real backup process in place for my own data. Since my hosting is self-managed (at [Slicehost](http://slicehost.com/ "Slicehost's web site")) without any sort of attached official backup plan, I'm definitely vulnerable to any sort of server failure. I've had a near miss a couple of times with personal computers--which I now back up often--but I've yet to set up anything recurring for my hosted files.

So, I took some time over the weekend and wrote a simple backup script with Ruby that saves the archive files to [Amazon S3](http://aws.amazon.com/s3/ "Amazon S3 information page"). A while back I tried something similar using [rsync](http://en.wikipedia.org/wiki/Rsync "Wikipedia entry for 'rsync'"), but at the time I stumbled on setting the SSH keys and all that up. Since I'm now using S3 to host images for [The Tools Artists Use](http://thetoolsartistsuse.com/ "The Tools Artists Use weblog"), adding another "bucket" to store some backups was a no-brainer.

The script works for me, and since it may be useful for others, I've put the code up on [my Github account](http://github.com/billturner/ "My main Github account page"): [simple-s3-backup](http://github.com/billturner/simple-s3-backup "A direct link to the 'simple-s3-backup' repository on Github").
