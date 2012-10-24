---
layout: post
title: "Zend Framework Deployment with Capistrano"
date: 2012-05-23 10:04
comments: true
categories: [tech, deployment, zend framework]
sharing: true
published: true
---

Personally, Ruby is my favourite programming language and whenever I have a choice in the matter I'll be using Ruby for any projects. Likewise, when building a web app I'll turn to Ruby-based frameworks like Rails or Sinatra. However, I know for me I don't always have a choice in the matter.

Currently one of my largest projects is maintaining and improving a very large and complex PHP / Zend Framework web application. To even think about porting this app to Rails would be off the table and despite such limitation, I want to make the process as comfortable as possible. To do so, I will still attempt to use the tools I'm familiar with whenever I can. *Enter Zend Framework deployment with Capistrano.*

I'm sure they're out there, but I'm not aware of any PHP or Zend Framework based deployment tools that even come close to the functionality of [Capistrano](https://github.com/capistrano/capistrano/wiki/Documentation-v2.x). The great thing about Capistrano is that you're not limited to using it with only Ruby and Rails based projects, but it actually works beautifully for any kind of project. In my case, it was an ideal deployment solution for this large PHP web application that I manage.

In this post I will detail exactly what you need to do to get your Zend Framework apps deploying with Capistrano. To play along you will need to have Ruby and Git installed on your system.

<!-- more -->

### Step One: Ensure project is using a Version Control System

If you are not currently using a Version Control System with your code, then you'll need to start doing so before ever contemplating an automated deployment solution. Capistrano requires a version control system since that is how it will know which files to deploy to your server for specific builds. It also allows Capistrano to roll-back builds when needed. With great tools like Git and Mercurial that are freely available along with a deluge of resources to help you get up and running, it's never been easier to get started with version control.

If you are not yet using Git, I would recommend a couple resources to help you get started: [Git Immersion](http://gitimmersion.com/), [Learn.GitHub "Introduction to Git"](http://learn.github.com/p/intro.html), and [Git Ready](http://gitready.com).

### Step Two: Setup Public-Key Authentication

If you don't want to be typing in the password every time you deploy your application, you'll need to set up Public-Key Authentication. I've covered how to do this in two previous posts: [here](http://derekbarber.ca/blog/2012/02/09/ssh-public-key-authentication/) and [here](http://derekbarber.ca/blog/2012/02/13/debugging-public-key-authentication/).

### Step Three: Configure Capistrano

Here comes the actual Capistrano set up. First, assuming you have Ruby on your system, start by installing both the capistrano and railsless-deploy gems:

    $ gem install capistrano
    $ gem install railsless-deploy

Now create a file called *Capfile* in the root directly of your ZF application. When working with Rails you can actually perform this task automatically using the "capify" command, however since we're not using Rails we'll need to create the file manually since the ZF project structure differs from a Rails project. The contents of this file should be as follows:

    require 'rubygems'
    require 'railsless-deploy'
    load 'application/configs/deploy.rb

The next file you will need to create is *deploy.rb* (which is referred to in Capfile) inside the "application/configs" folder of your ZF project. This file is where the bulk of your Capistrano configuation will be specified. Here is a generalized copy of the file from one of my projects:

    # Add colours to the Capistrano output
    require 'capistrano_colors'

    # What is the name of the local application?
    set :application, "MyApp"

    # Is sudo required to manipulate files on the remote server?
    set :use_sudo, false

    # How are the project files being transferred to the remote server?
    set :deploy_via, :copy

    # Maintain a local repository cache. Speeds up the copy process.
    set :copy_cache, false

    # Ignore any local files?
    set :copy_exclude, %w(.git)

    ######################################################
    # Git
    ######################################################

    # What version control solution does the project use?
    set :scm, :git

    # Where is the local repository?
    set :repository, "file:///Users/derekbarber/vhosts/myapp"

    #############################################################
    # Stages
    #############################################################
    set :stages, %w(production development)
    set :stage_dir, "application/configs/deploy"
    set :default_stage, "application" #if we only do “cap deploy” this will be the stage used.
    require 'capistrano/ext/multistage' #yes. First we set and then we require.

    #############################################################
    # Tasks
    #############################################################

    # Remove older realeases. By default, it will remove all older then the 5th.
    after :deploy, 'deploy:cleanup'

Hopefully the comments in the above lines make the content of the file fairly self-explainatory. I will however make a couple points about my specific configuration as each of the options do take multiple possible values and my values may not be the best values for your specific situation. I do recommend that you get familiar with the various options available and you can do so by taking a look at the Capistrano wiki and specifically the [Significant Configuration Variables article](https://github.com/capistrano/capistrano/wiki/2.x-Significant-Configuration-Variables).

In my example, you will notice that for the ":copy_cache" option, I chose "false" which is not the recommended choice. I simply was unable to get copy_cache working properly with my setup. I would recommend setting this "true" since it will greatly speed up your deployments, but if you run into any problems, you can do what I did and try turning off such an option to see if it helps.

A key aspect of my configutation is that I have specified multiple ":stages" for deployment. This allows me to deploy to both a development site and a production site. I use different branches in my Git repository to track my development and production versions of the application. This type of configuration requires additional files for each stage, which are stored in the "application/configs/deploy" folder. You can read more about this at this Capistrano wiki article: [Multistage Extension](https://github.com/capistrano/capistrano/wiki/2.x-Multistage-Extension). To help further clarify this, here is an example of the configuration file for my development stage:

    #############################################################
    # Servers
    #############################################################

    # What is the user that will connect to your Development server?
    set :user, "development"

    # What is the domain name of your development server ?
    role :web, "dev.myapp.org"

    # What is the directory path used to store your project on the remote server?
    set :deploy_to, "/home/vhosts/dev.myapp.org/htdocs"

    # What is the branch in your Git repository that will be deployed to the development server?
    set :branch, 'unstable'

    # Specify the development configuration file
    task :create_symlinks, :roles => :web do
      run "rm #{current_release}/application/configs/application.ini"
      run "ln -s #{current_release}/application/configs/production/development.ini #{current_release}/application/configs/application.ini"
    end

    # After the deployment, we call the created task (create_symlinks):
    after "deploy:finalize_update", :create_symlinks

With most of the settings in the above file you can simply replace them directly with the settings for your specific application and server configuration. However, please pay close attention to the **task** block as it is a critical piece of the puzzle. What is going on here is that I am ensuring that the correct configuration file is in place for the correct stage. In my case, each stage requires some slightly different configuration options, such as which database server to connect to and what the base URL for the application happens to be. What I do is store separate configuration files for each stage and then symlink it into the proper location based upon the stage that is being deployed.

### Step Four: Try it out

Once you have created your own configuration files and customized the values for your specific situation, you can then give it a try. To prepare your project for deployment, first run this command which will create the necessary Capistrano folders on your remote server:

    cap production deploy:setup
    
Assuming that task executes successfully, you are now ready for the first full deployment of your application. To proceed, enter the following command which is only used the first time that you deploy a new application:

    cap production deploy:cold
    
For all subsequent deployments, you can run the slightly simpler command:

    cap production deploy

And of course, if you ever deploy a bad build that breaks your application, you can roll it back with a single command:

    cap production deploy:rollback

In the above commands you will notice that I specifed the *production* stage as the target, keep in mind that if you have a multi-stage deployment you will need to re-run the above commands for each stage. For exapmle, when deploying for my development stage, the command will look like this:

    cap development deploy

Additionally, if you only have a single stage application, you can simply run any capistrano command without specifying the stage. To get a full list of all the capistrano tasks that are available for your project, type in the following command:

    cap -T

It might be a little scary the first time you deploy but soon you should get used to the incredible ease with which you can deploy new builds of your web application. I can't imagine ever going to back to a manual deployment process and I shutter slightly when thinking about how much time I've wasted in the past doing manual deployments.

### Conclusion

Well, that was quite the whirlwind tour of using Capistrano for deploying a Zend Framework application. I hope it was helpful. Please don't hesitate to leave a comment below or get in touch directly if you have any questions about this article.
