---
layout: post
title: "Conway's Game of Life in Ruby"
date: 2015-03-04 14:50:05 -0800
comments: true
sharing: true
categories: [ruby, rspec]
published: true
---

Conway's Game of Life is one of those foundational programming exercises that goes back to the
early days of computer programming. If you haven't heard of it before, I encourage you to read all about it
at [Wikipedia](http://en.wikipedia.org/wiki/Conway%27s_Game_of_Life).

My interest in Conway's Game of Life was recently piqued when I read Corey Haines excellent little
book [Understanding the Four Rules of Simple Design](https://leanpub.com/4rulesofsimpledesign). I highly
recommend the book to any software developer who is seeking to improve their skills in the craft
of software design. The book details the lessons learned from applying the Four Rules of Simple Design 
(*which were first articulated by Kent Beck*) to Conway's Game of Life.

In reading the book and going through all the examples, which were based around the Game of Life, I 
realized that I had never written an implementation of the Game of Life myself. I thought it was high time to
and go ahead and do that. Since my current programming language of choice is Ruby, and also since the examples
in Corey's book use Ruby, I decided to implement my version in Ruby as well.

<!-- more -->

I used a test-driven approach to writing the code with RSpec, and also used the Gosu 2D game development
library to generate the nice looking output. It was a very worthwhile exercise and I found it got me
thinking about different programming problems than I normally do in my day to day work. Plus watching
the end result as cells are born and die is a lot of fun.

You can find the resulting implemention [at my Github account](https://github.com/derekbarber/game_of_life).
As I note in the Readme, the code is indebted to another Ruby implementation of the Game of Life, which I leaned
on heavily for inspiration. Eventually I would like to try re-writing the implementation from scratch and 
work in some of the exercises from Corey Haines' book at the same time.

Please send me any feedback or ideas on how I could improve the code (or just open a pull request). 

If you're a programmer and haven't yet implemented the Game of Life in your language of choice, I would
highly recommended giving it a try.