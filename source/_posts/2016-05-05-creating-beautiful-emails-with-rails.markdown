---
layout: post
title: "Creating Beautiful Emails With Rails"
date: 2016-05-05 17:15:10 -0700
comments: true
published: false
categories: rails
---

In most of my Rails projects, the basic out-of-the-box email layouts do the 
trick. They're not pretty but they get the job done. If you are just sending
out simple text emails then it's fine. However, on some projects the
basic template doesn't cut and we need something nicer. Would it be great
if you could get Rails to send out emails that look similiar to those
sent by Mail Chimp or other professional email marketing apps.

Well, it's actually not that hard to improve your email layouts in Rails
and get something that looks great. 

Step One: Install the premailer-rails gem

The premailer-rails gem is a drop in solution for automatically applying
your CSS styles to your HTML emails.

Step Two: Spice up your mailer layout

Don't try and re-invent the wheel here. There are some great boilerplate
HTML email templates that you can use to give you a solid foundation
for your email design. My favourite option is actually provided by
Mailchimp and it's called "Email Blueprints". 

https://github.com/mailchimp/email-blueprints

Step Three: Design your Mailer Layout & CSS

Step Four: Setup Asset Precompilation

Add your mailer.css to config/initalizers/assets.rb

Step Five: Setup your Mailers

Step Six (Optional): Set up Devise


