---
layout: post
title: "My Current Development Setup"
date: 2012-12-25 15:39
comments: true
categories: [ruby, osx]
sharing: true
published: false
---

Recently, I picked up a 13" Macbook Air for developing on the go. Below are all the steps I took to setup OS X Mountain Lion 
for Ruby development. Feel free to duplicate the setup if you find it useful.

### Dropbox

The first application I install on any machine is [Dropbox](http://db.tt/sfmZgWt). Dropbox is a free service which allows you to 
share files with all your devices/computers. It is my first application because there are essential files other applications 
require, such as 1Password.

### 1Password

I never use the same password for any service. [1Password](https://agilebits.com/onepassword) solves this problem for me as it is a great password manager that has 
browser extensions and iPhone/iPad apps. Once 1Password is installed, I have access to any sites/services I may need to continue 
my computer setup.

### Web Browsers

Given I primarily do Ruby on Rails development, I require that all primary browsers are represented on my machine so I can 
test how sites look. Browsers I install are:

[Chrome](https://www.google.com/intl/en/chrome/)
[Firefox](http://www.mozilla.org/en-US/firefox/new/)


### VirtualBox

Internet Explorer is the only browser you cannot install on your Mac. To test IE, you must use virtual machines.

Microsoft does provide virtual machine disk images to test on multiple versions of IE, however they are meant to run on 
VirtualPC. To get around this, there is a great project ievms that installs all the virtual machines on your machine to 
be used with Virtual Box.

To use [ievms](http://xdissent.github.com/ievms/):

Install [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
Run: $ curl -s https://raw.github.com/xdissent/ievms/master/ievms.sh | bash

### Iterm2

I prefer using [ITerm2](http://www.iterm2.com/) over Terminal. If you haven't tried it out in the past, give it a shot.

### Switch to Zsh

Zsh is my preferred shell. To switch the shell from bash, run:

$ chsh -s /bin/zsh

### SSH Keys

To use services such as GitHub and Heroku, SSH keys are required. For extra security, I generate a different key per machine.

To generate a new key, I run the following:

$ ssh-keygen -t rsa -C "kevin@remarkablelabs.com"
When generating a key, ssh-keygen will prompt for a passphrase. Always enter a password for your keys as it will ensure they 
are more secure.

Once generated, the public key is available at ~/.ssh/id_rsa.pub. Copy this key to your clipboard via $ pbcopy < ~/.ssh/id_rsa.pub. Then you can add it to any service that requires it.

### Xcode & Command Line Tools

To get the latest Xcode, go to the App Store. Once installed, you must install the Command Line Tools. Open Xcode, and
from the menu click Xcode -> Preferences. There you will find a Downloads tab where you will be able to download and 
install the Command Line Tools. You will need the Command Line Tools to install versions of ruby and software from HomeBrew.

### Homebrew

Homebrew is a package manager on the Mac. It is an essential install for any machine and will be needed in the steps ahead.

To install Homebrew, run:

$ ruby -e "$(curl -fsSkL raw.github.com/mxcl/homebrew/go)"

### apple-gcc42

To install older versions of Ruby, you are going to need GCC 4.2, which is no longer included with Mountain Lion. Run the 
following commands to add it to your system:

$ brew tap homebrew/dupes
$ brew install autoconf automake apple-gcc42

### Git

The next step is installing the latest version of Git. Add it by running:

$ brew install git
I also include hub, as it provides some great commands to work with GitHub.

$ brew install hub

### Dotfiles

My dotfiles are standard on all my machines. It sets all my ZSH settings, including aliases, settings environment variables, etc.

To install them, I clone my public repository from GitHub from my home directory and run:

$ git clone git://github.com/kfaustino/dotfiles.git bin
$ cd ~/bin/dotfiles
$ rake install
This will setup everything correctly in my home directory and customize my .gitconfig based on what I input during the install.

### rbenv

I like to manage my rubies with [rbenv](https://github.com/sstephenson/rbenv). It is very simple way to install ruby versions. To install rbenv, run:

brew install rbenv
brew install ruby-build
Personally I start all my development work these days with Ruby 1.9.3-p327. I install it and make it my global ruby by running the following:

$ rbenv install 1.9.3-p327
$ rbenv global 1.9.3-p327

### PostgreSQL

PostgreSQL is my default relational database these days. Installing it is a simple as running two commands:

$ brew install postgres
$ initdb /usr/local/var/postgres -E utf8
Everything else

Here is list of various other things I install during the setup process. These are all available through HomeBrew:

Ack
ImageMagick
elasticsearch
Memcached
MongoDB
Redis