---
layout: post
title: "SSH Public Key Authentication"
date: 2012-02-09 08:49
comments: true
published: true
categories: [tech, ssh]
---

Do you use SSH to log in to a remote server? If so, do you type your password in every time you log in?
*Did you know that you don't have to?*

In addition to being more convenient, public key authentication is also more secure since your password
is not transmitted over the network. It's also relatively quick and easy to set up, and I hope
the following information will be helpful in that regard.

With SSH public key authentication, instead of using your password to authenticate,
it will instead use your public key. Of course the public key is only half of the solution, the other half
is your private key. These two keys work together, so that a message encrypted using your public key can only
be decrypted with your private key. It is important to remember that you can freely distribute your public key
but you must never give your private key to anyone.

<!-- more -->

Public key authentication with SSH works by having your public key reside on the server, inside your
account's home directory. When you connect to the server using SSH, the server will encrypt a message using
your public key and send it to you. SSH will then use your locally stored private key to decrypt that message
and thus prove to the server that you are the bearer of the private key. Once your identity is authenticated
through this exchange, you will be given access to your account on the server.

The following commands should work on any Unix-based system such as Mac OS X or Linux. If you are on
Windows, please check out [PuTTY](http://www.chiark.greenend.org.uk/~sgtatham/putty/) for information
on using SSH on Windows.

### Step 1: Generate your key pair

If you don't yet have a key pair, you'll need to generate that first. The following command will generate
a new RSA key pair:

    $ ssh-keygen -t rsa
    Generating public/private rsa key pair.
    Enter file in which to save the key (/home/derek/.ssh/id_rsa):
    Enter passphrase (empty for no passphrase):
    Enter same passphrase again:
    Your identification has been saved in /home/derek/.ssh/id_rsa.
    Your public key has been saved in /home/derek/.ssh/id_rsa.pub

Unless you have a good reason not to, you should accept the default location for the keys. You will also be
asked for a passphrase, you can leave this blank for convenience but it's more secure to have one.
In the above example my private key is stored in the **id_rsa** file, and my public key is stored in
the **id_rsa.pub** file. If you're curious, feel free to open those files in a text editor and take
a look at their contents.

If you do enter a passphrase you will want to use a tool called "ssh-agent" to cache your private key
so that you won't need to type in the passphrase every time. Use the following command to do so:

    $ ssh-add ~/.ssh/id_rsa
    Need passphrase for /home/derek/.ssh/id_rsa
    Enter passphrase:

### Step 2: Copy your public key to the remote server

Once you have your key-pair, you'll need to use scp to securely copy your public key
up to the remote server:

    $ scp ~/.ssh/id_rsa.pub username@remote:publickey.txt

Then you should log into the server so that you can move your public key into the correct
location. As you will note in the following commands, it is also essential to have the
permissions set correctly both the .ssh directly and on your public key, so that only your
user account has access to those items.

    $ ssh username@remote
    ...
    $ mkdir ~/.ssh
    $ chmod 700 .ssh
    $ cat publickey.txt >> ~/.ssh/authorized_keys
    $ chmod 600 ~/.ssh/authorized_keys
    $ logout

### Step 3: Try it out!

Once that is all done you should be all set to log in to your remote server. Simply type in the
ssh command as you normally would and within moments you should be securly logged into your
remote account.

I hope this post has been helpful, please get in touch if you have any questions. I am
also planning a follow-up which will cover some SSH troubleshooting and should
hopefully give solutions to some common issues you might experience.

