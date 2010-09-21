---
layout: post
date: 2010-09-20T22:01:00-05:00
title: Simple bash aliases for Jekyll
excerpt: Some bash aliases to help make blogging with Jekyll a little easier
tags:
- jekyll
- bash
---
As I get a little more comfortable with how [Jekyll](http://github.com/mojombo/jekyll "The Jekyll weblog software") works, I've found a few Bash aliases that have been helping out. Below are four aliases I have set up to make blogging with Jekyll easier (with a little explanation for each).

    # let's write an entry (cd to path and open up TextMate)
    alias timetoblog="cd ~/code/blog && mate ."

    # start up Jekyll for local preview of blog
    alias serveblog="cd ~/code/blog && jekyll --server --auto"
  
    # delete the existing built site and rebuild
    alias buildblog="cd ~/code/blog && rm -rf _site/ && jekyll"
  
    # use rsync to push the weblog to my host
    alias deployblog="cd ~/code/blog && rsync -rtz --delete _site/ username@host.com:~/path/to/weblog/root/"

Each of these assume a little on how you have Jekyll configured, so you will have to adjust each for your own setup. You can see [my own configuration options on Github](http://github.com/billturner/brilliantcorners.org/blob/master/_config.yml "Link to my own Jekyll configuration file.").

Some of these tips originally came from the [Jekyll wiki](http://wiki.github.com/mojombo/jekyll "Jekyll wiki") and various [weblog](http://asymmetrical-view.com/2009/05/14/starting-wtih-jekyll.html "Weblog post on getting started with Jekyll") [posts](http://alexyoung.org/2009/07/09/new-blog/ "Another weblog post on using Jekyll").
