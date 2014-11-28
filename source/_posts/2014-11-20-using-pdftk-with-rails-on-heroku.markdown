---
layout: post
title: "Using PDFtk with Rails on Heroku"
date: 2014-11-20 09:15:50 -0800
comments: true
categories: 
---

In a previous post I detailed how I used 

https://github.com/SirRawlins/pdftk-source

      mkdir -p [my_project]/vendor/pdftk/lib [my_project]vendor/pdftk/bin
      cd /tmp
      git clone https://github.com/millie/pdftk-source.git
      cd pdftk-source
      tar xzvf pdftk.tar.gz
      mv bin/pdftk [my_project]/vendor/pdftk/bin/
      mv lib/libgcj.so.12 [my_project]/vendor/pdftk/lib/
      cd [my_project]
      git add -f vendor/pdftk/
      git commit -m "Add pdftk dependencies"
      git push heroku master
      heroku config:set LD_LIBRARY_PATH=/app/.heroku/vendor/lib:/app/vendor/pdftk/lib
      heroku config:set PATH=/app/.heroku/python/bin:/usr/local/bin:/usr/bin:/bin:/app/vendor/pdftk/bin
      heroku run bash
      $ pdftk