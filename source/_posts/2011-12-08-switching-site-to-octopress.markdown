---
layout: post
title: "Hello Octopress"
date: 2011-12-08 11:18
comments: true
sharing: true
published: true
categories: [tech, octopress, blogging]
---

This is my first post on my new [Octopress](http://octopress.org "Octopress")-powered site.

Prior to today, this site was driven by Wordpress and overall I was fairly happy with it.Wordpress is indeed a powerful platform and as an experienced PHP developer, I can dig into the source code and tweak things to my heart's content. For many of the sites I manage, Wordpress is an excellent option and I will continue to use it for those sites. However, for a simple blog like this, Wordpress tended to get in the way more often than not, and I found I would get caught up in *managing* all the various plugins and themes more often than simply *writing*.

<!-- more -->

### Baked vs. Fried ###

It was around the time of this growing discontent that I stumbled across some articles on *baked blogs* vs. *fried blogs*. Some of the most convincing posts in favour of *baking* came from Brent Simmons, including: [New publishing system / tour of my head](http://inessential.com/2009/01/30/new_publishing_system_tour_of_my_head), [A plea for baked weblogs](http://inessential.com/2011/03/16/a_plea_for_baked_weblogs) and [More on baked blogs](http://inessential.com/2011/03/17/more_on_baked_blogs). 

The essential difference between these two approaches is that *fried sites* are build on demand by the user through a database lookup. In general, a fried site (assuming you're not doing any caching) will perform a database lookup for each page view, and hence a large influx of visitors can create such a server load that the site will go down. On the other hand, *baked sites* are built from a bunch of scripts which output static web pages. You generally updates these static pages whenever you add or update a post. It is these static web pages that are then accessed by visitors. Not only can this speed up page load time but it can also protect you from getting [fireballed](http://fireballed.org/).

### Wordpress Alternatives ###

All that got me thinking about looking for a baked alternative to Wordpress, and if I couldn't find the right one I even thought about writing my own from scratch. There was some specific features that was looking for such as being able to write all the blog posts in [Markdown](http://daringfireball.net/projects/markdown/) and of course I wanted something that was written in Ruby. Over the past several years Ruby has become my programming language of choice and so I'm always looking for opportunities to use it.

In my search I first found [Jekyll](https://github.com/mojombo/jekyll), which the static site generator written in Ruby that is used on [Github Pages](http://pages.github.com). If you've visited Github Pages then you've seen Jekyll in action. Jekyll is fantastic but it does require you to create all your own HTML Templates, CSS and any JavaScript from scratch. Wouldn't it be great if someone took Jekyll but then built a framework around it so that it could be complete solution? This is where Octopress comes in.

### Octopress ###

Octopress is exactly the solution I was looking for. Build on the solid foundation of Jekyll, it provides a complete blogging framework with everything you need including:

 * A beautiful semantic HTML5 template
 * A Mobile friendly design
 * Easy deployment
 * Build in support for Twitter, Google+, Disque Comments, etc..
 * Much, much more...
 
It is incredibly easy to get started with Octopress and the official site at [octopress.org](http://octopress.org) lays out the process step by step. For myself, within about an hour reading the documentation and following the detailed instructions, I had a working site.

I was also able to easily migrate my Wordpress posts over to Markdown files using [Exitwp](https://github.com/thomasf/exitwp). So, if you're a Wordpress user and you're looking for a static blog alternative, no more excuses, you can easily make the switch over to Octopress. I'm definitely glad I did.




