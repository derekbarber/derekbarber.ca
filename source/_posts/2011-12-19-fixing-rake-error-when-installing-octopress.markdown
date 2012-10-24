---
layout: post
title: "Fixing Octopress Rake Error" 
date: 2011-12-19 10:04
comments: true
sharing: true
published: true
categories: [octopress, blogging, rake]
---

Octopress is a fantastic blogging platform and as I documented in a [recent post](http://derekbarber.ca/blog/2011/12/08/switching-site-to-octopress/), converting this site from Wordpress to Octopress was a smashing success. However, I did run into a minor hitch and thought it might be helpful to document the fix.

Today I started work on migrating another website over to Octopress and I ran into a problem with rake. Interestingly enough, I encountered this problem previously but didn't document the solution. Since this is my second time seeing this error, I thought it might be helpful to document both the error and how I resolved it.

<!-- more -->

As documented on the [Octopress site](http://octopress.org/docs/setup/) I got started with this new site by first cloning the Octopress git repository, installing any dependencies and then proceeding with the default theme installation. This is where I encountered the rake error:

    $ rake install
    rake aborted!
    You have already activated rake 0.9.2.2, but your Gemfile requires rake 0.9.2. Using bundle exec may solve this.

The Gemfile requires rake 0.9.2 but I actually have a slightly newer version of rake installed. So, the solution is to let Bundler know that a newer version of rake is acceptable. To do so, I opened the *Gemfile* in the root directory of my Octopress site and updated the line for rake as follows:

    gem 'rake', '>= 0.9.2'

I then saved the file and ran *bundle update* on the command line:

    $ bundle update

What this does is update the Gemfile.lock file so that Bundler will accept any version of rake greater than or equal to 0.9.2.

I was then able to run *rake install* and have the installation execute successfully:

    $ rake install
    ## Copying classic theme into ./source and ./sass
    mkdir -p source
    cp -r .themes/classic/source/. source
    mkdir -p sass
    cp -r .themes/classic/sass/. sass
    mkdir -p source/_posts
    mkdir -p public

I hope this solution helps someone. If anyone knows of a better way to fix the error, please let me know.