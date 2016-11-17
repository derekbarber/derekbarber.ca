---
layout: post
title: "Scheduling Background Jobs in Rails"
date: 2015-09-10 11:00
comments: true
sharing: true
published: true
categories: [rails, sidekiq, cron]
---

A common task that I encounter regularly in my Rails apps is needing to 
setup a background job that runs on a regular schedule.
Essentially what we want is a cron job but the last thing I want to be doing
is fiddling around with a crontab on the server. It would be much better 
if I could configure the scheduling within my Rails app itself and then 
I can keep the schedule configuration under source control. This makes
makes it easy to update the schedule and have updates deployed automatically 
along with my app.

Thankfully we don't have to build this functionality from scratch as there
is a great Ruby gem called [Whenever](https://github.com/javan/whenever) that 
allows us to set up cron jobs from within our Rails apps using Ruby code. 
In this blog post I'll cover how you can schedule your background jobs in Rails
using Whenever to set up your schedule, along with Sidekiq to run the actual 
background jobs.

<!-- more -->

### Getting Started

To get started simply add the whenever, sidekiq and sidekiq-client-cli
gems to your Gemfile:

``` ruby Gemfile
gem 'sidekiq'                                                                                                                        │Started GET "/auction_vehicles/30" for ::1 at 2015-09-09 16:49:05 -0700
gem 'sidekiq-client-cli'
gem 'whenever', :require => false
```

After updating your Gemfile, run `bundle install` to install the 
gems. I should also point out that [Redis](http://redis.io/) is
a required dependency of Sidekiq and so you'll need to get that installed
in both your dev and server environments. For further details on 
using Redis with Sidekiq please check out the [Using Redis](https://github.com/mperham/sidekiq/wiki/Using-Redis)
page on the Sidekiq wiki.

Also, if you were wondering why we need the `sidekiq-client-cli` gem 
in addition to sidekiq, it is actually the key piece of the puzzle.
The sidekiq-client-cli gem is a command line client for 
Sidekiq and allows the cron jobs to interact with Sidekiq,
without it our cron jobs could never execute a Sidekiq worker.

### Creating Your Background Workers

Now that we have all the required gems installed we can get started
with creating our background workers.

To do that I create a folder called `app/workers` in my Rails application 
and create a simple class there for each of my background jobs. 
In order to run these jobs in the background with Sidekiq you just
need to include the `Sidekiq::Worker` mixin and create a `perform` method
which contains the actual work to be performed.

Here is an example of what your class might look like:

``` ruby app/workers/cron_job.rb
class CronJob
  include Sidekiq::Worker
  def perform
    # stuff to do goes in here
  end
end
```

Once your background job is created and ready to be executed we can
now turn to **whenever** and set it up to run the job on a predetermined
schedule.

### Scheduling Your Background Jobs

To get started with whenever, you can run the `wheneverize` command in 
your app's root folder to set up an initial configuration:

```console
wheneverize .
```

The wheneverize command will create an initial `config/schedule.rb`
file for you. I recommended opening it up and taking
a look at some of the default configuration options to get an idea of
how whenever works. 

Below is an example of a `config/schedule.rb` that executes our 
CronJob worker's perform method once every thirty minutes. However,
before we look at the configuration here are a couple things to note:

 * The first configuration option sets up a `job_type` called `:sidekiq`, 
 this makes sure that the job is sent to the sidekiq-client binary. 
 * All you need to do to specify which job to run is to include 
 the name of the class that you created in your workers folder. You don't
 need to mention the `perform` method, Sidekiq is expecting that
 method already exists and so it's assumed to be there. 

In the above example we created a class called `CronJob` and so that is what 
we pass along to the sidekiq job:

``` ruby config/schedule.rb
job_type :sidekiq, "cd :path && :environment_variable=:environment bundle exec sidekiq-client push :task :output"

every 30.minutes, :roles => [:app] do
  sidekiq "CronJob"
end
```

As you can see **whenever** makes it incredibly easy to schedule your
background jobs. Of course this is just a very basic configuration
and you can get much more complex as needed. However, one additional 
configuration that you will need is for your deployment pipeline 
to update your server's crontab with your whenever schedule.

### Deploying Your Background Jobs

I personally use Capistrano to deploy my rails apps and thankfully it 
makes it very easy to set up your deployment process to update your server's 
cron jobs based upon your whenever configuration. Here is an example from my
`config/deploy.rb` which sets up a capistrano task called 
`update_cron` to update my crontab with whenever.

``` ruby config/deploy.rb
namespace :deploy do
  desc "Update crontab with whenever"
  task :update_cron do
    on roles(:app) do
      within current_path do
        execute :bundle, :exec, "whenever --update-crontab #{fetch(:application)}"
      end
    end
  end

  after :finishing, 'deploy:update_cron'
end
```

The `update_cron` task is set to run after capistrano completes the
deployment so that it will use the latest version of `config/schedule.rb`
for configuration. 
  
After setting up that capistrano task you can run it directly and
then check on your server to verify the updates to your crontab.

```console
cap production deploy:update_cron
```

After the task runs successfully you can log in to your remote server
and view your crontab as follows:

```console
crontab -l
```

Assuming everything is hooked up correctly you should now be seeing
that your server's crontab mirrors your whenever configuration.

There is much more that could be explored here, however I hope this
gives a good overview on how to get started. Let me know in the
comments if you have any further questions or any feedback on
the article.


