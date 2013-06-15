---
layout: post
date: 2011-02-15T21:28:00-05:00
title: Building Vim on OSX Snow Leopard
description: How to compile a new version of Vim on OSX Snow Leopard
tags:
- osx
- vim
---
<div class="update-available">
  <h3>Update! Update!</h3>
  <p>
    While the instructions below still work, there are easier ways to accomplish getting Ruby support in Vim on a Mac. <a href="http://prioritized.net/blog/upgrading-vim-on-os-x/">This post</a> on Derek Prior's weblog lists several other options that don't involve manual compilation. I would try one of those before messing around with compiling Vim on your own.
  </p>
</div>

Although I haven't abandoned [TextMate](http://macromates.com/ "The TextMate homepage") as my editor of choice for day-to-day coding, I have been taking the time to really learn [Vim](http://www.vim.org/ "The Vim homepage") and all it can do. I've used Vim for 10+ years, but with only the most basic of commands for editing files on remote servers, or quick changes to various config files. As I learn more, I'm finding that Vim can do just about everything I'm used to in TextMate, and in some cases, more.

I've been using [MacVim](http://code.google.com/p/macvim/ "The MacVim homepage") for learning, which is a full-featured, native app for OSX. It has built in support for everything you want to do or add on: 256 colors, Ruby support, etc. But if you're in Terminal.app and fire up `vim`, you'll find that some of your (_my_) favorite plugins that work fine in MacVim, do not work (specifically: [Command-T](https://wincent.com/products/command-t "The Command-T homepage") needs Ruby support, and [ConqueTerm](http://code.google.com/p/conque/ "The ConqueTerm homepage") needs Python support). The default Vim install in OSX lacks a lot of the niceties that come by default with MacVim. Here's how I built a new version of Vim for using in Terminal.app.

The Vim download page suggests using [Mercurial](http://mercurial.selenic.com/ "The Mercurial homepage") to fetch the latest version of the source if you want to compile it yourself. [Here are some options for installing Mercurial on OSX](http://mercurial.selenic.com/wiki/Download#Mac_OS_X "Three options for installing Mercurial on OSX"). Once that's done, you'll want to find a place to fetch the source. I put mine in `~/tmp/`.

    # fetch the source into a vim directory
    hg clone https://vim.googlecode.com/hg/ vim

    cd vim

    # make sure you're up to date
    hg pull
    hg update

Now that you have the latest version of the source, it's time to compile your own version of Vim:

    # configure to install in /usr/local/bin and make sure Ruby and Python
    # support are built in
    ./configure --prefix=/usr/local --enable-rubyinterp --enable-pythoninterp --with-features=huge

    # build
    make

    # after it's finished building, you can double check that the support you 
    # want is now built in with this command:
    ./src/vim --version

In the output from that command, you should see `+ruby` and `+python` which signifies that both Ruby and Python support are built in, and that's what I needed. Since the newly built Vim is what we want, install it:

    make install

In order to make sure that _this_ Vim is used when typing `vim` at the command line, make sure that `/usr/local/bin` comes first in your path. This way our full-featured Vim at `/usr/local/bin/vim` will be called instead of the OSX built-in version at `/usr/bin/vim`. For reference, this is how I set path in my `~/.bashrc`:

    export PATH="/usr/local/bin:/usr/local/pgsql/bin:/usr/local/php5/bin:/usr/local/sbin:/usr/local/mysql/bin:$PATH"

And now you have a version of Vim that should allow you to add on just about any plugin available. But, if you want to take advantage of themes with 256 colors, you won't be able to do that in Terminal.app, but a replacement like [iTerm2](http://code.google.com/p/iterm2/ "The iTerm2 homepage") would work just fine.

If you ever need to recompile a newer version, or just to try some different configuration options, you'll need to clean up the build directories and update the source beforehand:

    # thoroughly clean the source tree
    make clean
    make distclean

    # update vim source
    hg pull
    hg update default

Then you can proceed with the configuration and build steps above.

---

References:

* <http://www.vim.org/mercurial.php>
* <https://wincent.com/wiki/Installing_Vim_7.3_beta_on_Mac_OS_X_10.6.4_Snow_Leopard>
* <http://mercurial.selenic.com/wiki/Download#Mac_OS_X>

