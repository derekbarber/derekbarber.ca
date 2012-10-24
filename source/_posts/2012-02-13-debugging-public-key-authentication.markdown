---
layout: post
title: "Debugging Public Key Authentication"
date: 2012-02-13 10:30
comments: true
categories: [tech, ssh]
sharing: true
published: true
---

This is a follow-up to my recent post on [SSH Public Key Authentication](http://derekbarber.ca/blog/2012/02/09/ssh-public-key-authentication/). I was setting up a remote account with public key authentication so that it would work with my capistrano deployment process. Basically I wanted to be able to run *cap deploy* and have it execute without needing to type in the password of the remote account. While setting this up I ran into an issue that I thought would be helpful to document, both the problem and the solution.

I set everything up as expected, copying my public key into the ~/.ssh/authorized_keys file on the remote server. However, it just didn't work. Whenever I tried to log into the server, instead of immediately logging me on, it still gave me the password prompt. In order to dig a little deeper and find out exactly what was going on, I ran the ssh command in verbose mode (adding -v). This showed me that my public key was offered but then rejected:

<!-- more -->

    $ ssh -v derek@xyz.com
    .....
    debug1: Authentications that can continue: publickey,password,keyboard-interactive
    debug1: Next authentication method: publickey
    debug1: Offering RSA public key: /Users/derek/.ssh/id_rsa
    debug1: Next authentication method: keyboard-interactive
    debug1: Authentications that can continue: publickey,password,keyboard-interactive


So, that confirmed my suspicion that the server was rejecting my public key. In order find out *why* the server was rejecting my key, I needed to get the SSH server to give me additional details. To do so, I turned on AUTH logging in the /etc/ssh/sshd_config file on the server. My relevent portion of my sshd_config file looked like this:

    SyslogFacility AUTH
    SyslogFacility AUTHPRIV
    LogLevel INFO

After restarting sshd (/etc/init.d/sshd restart) I tried again to authenticate using my public key, and expected the key was rejected. However, thanks to turning on AUTH logging, the details of my login attempt were captured in the server logs (/var/log/messages to be exact):

    Authentication refused: bad ownership or modes for directory /home/derek

It was from the above log message that I was able to figure out the problem, it was simply one of permissions. SSH is very particular about the permissions on your home folder, the .ssh folder and the authorized_keys file. The solution thus involved adjusting permissions to make sure they conformed to what SSH expected. SSH wants only **your** user account to have *write access* to your home directory (group can have read), and then only it can have *read access* to your .ssh folder and your authorized_files file (group cannot have read).

I was then able to fix the permissions by using the following commands:

    chmod go-w ~/
    chmod 700 ~/.ssh
    chmod 600 ~/.ssh/authorized_keys

After doing that I tried again and voilà - it worked!
