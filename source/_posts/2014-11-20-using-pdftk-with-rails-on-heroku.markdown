---
layout: post
title: "Using PDFtk with Rails on Heroku"
date: 2014-11-20 09:15:50 -0800
comments: true
published: true
sharing: true
categories: [rails, heroku]
---

I recently worked a Rails project in which I had to automate the process of filling
out a PDF form from the app. To do so I utilized a gem called
[pdf-forms](https://github.com/jkraemer/pdf-forms) which worked great. If this is something
that you need to do, I would recommended checking out the article [Pre-Filling PDF Form Templates in Ruby-on-Rails with PDFtk](http://adamalbrecht.com/2014/01/31/pre-filling-pdf-form-templates-in-ruby-on-rails-with-pdftk/) which
gives some code examples on how to structure your code when working with pdf-forms.

The key dependency which pdf-forms utilizes for working with PDF files is [PDFtk](https://www.pdflabs.com/tools/pdftk-server/)
which is a command line tool for interacting with PDFs. As such, in order to use pdf-forms you'll
need a binary of PDFtk which pdf-forms can access. On my local dev environment this was no problem, just a matter
of downloading and installed the binaries for my platform. However it was a different story when it came to deploying the app on 
heroku and getting it working there.

It took a bit of digging but I eventually got it working and thought it would be worth sharing here
in case someone runs into the same issue.

<!-- more -->

The following code worked for me, but you might need to make some changes to get it working on 
your system. If you have any questions, don't hesitate to comment below and I'll do my best to help. 

**The first step is to download a binary of pdftk that will work on heroku and add it to your
Rails app:**

```
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
```

**Once that is done you can push up your changes to heroku and then set up the necessary
environment variables so that heroku knows where to find this new binary:**

```
git push heroku master
heroku config:set LD_LIBRARY_PATH=/app/.heroku/vendor/lib:/app/vendor/pdftk/lib
heroku config:set PATH=/app/.heroku/python/bin:/usr/local/bin:/usr/bin:/bin:/app/vendor/pdftk/bin
```

**Finally you can try it out and confirm that pdftk is now working on your heroku instance by running
bash and trying it out:**

```
heroku run bash
$ pdftk
```

If pdftk is working then you should see a bunch of help output from pdftk and that means you are now good
to go. Your deployed app should be able to work with pdfs and generate beautifully filled out pdf forms.