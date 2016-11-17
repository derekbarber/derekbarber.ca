---
layout: post
title: "Using WkHtmlToPdf with Rails on Ubuntu"
date: 2015-08-29 16:57
comments: true
sharing: true
published: false
categories: [rails, api, rspec]
---

Installing wkhtmltopdf on Ubuntu Server 12.04 to dynamically create PDF documents from HTML.

apt-get install wkhtmltopdf
apt-get install xvfb
echo 'xvfb-run --server-args="-screen 0, 1024x768x24" /usr/bin/wkhtmltopdf $*' > /usr/bin/wkhtmltopdf.sh
chmod a+rx /usr/bin/wkhtmltopdf.sh
ln -s /usr/bin/wkhtmltopdf.sh /usr/local/bin/wkhtmltopdf
wkhtmltopdf http://www.google.com output.pdf

References

https://github.com/pdfkit/pdfkit/wiki/Installing-WKHTMLTOPDF
http://stackoverflow.com/questions/9604625/wkhtmltopdf-cannot-connect-to-x-server
http://stackoverflow.com/questions/8805032/xvfb-run-error-in-ubuntu-11-04


1. Download wkhtmltopdf. Or better install it with a package manager:

sudo apt-get install wkhtmltopdf

2. Extract it and move it to /usr/local/bin/

3. Rename it to wkhtmltopdf so that now you have an executable at /usr/local/bin/wkhtmltopdf

4. Set permissions: sudo chmod a+x /usr/local/bin/wkhtmltopdf

5. Install required support packages.

sudo apt-get install openssl build-essential xorg libssl-dev

6. Check to see if it works: run

/usr/local/bin/wkhtmltopdf http://www.google.com test.pdf

If it works, then you are done. If you get the error "Cannot connect to X server" then continue to number 7.

7. We need to run it headless on a 'virtual' x server. We will do this with a package called xvfb.

sudo apt-get install xvfb

8. We need to write a little shell script to wrap wkhtmltopdf in xvfb. Make a file called wkhtmltopdf.sh and add the following:

xvfb-run -a -s "-screen 0 640x480x16" wkhtmltopdf "$@"
Move this shell script to /usr/local/bin, and set permissions:

sudo chmod a+x /usr/local/bin/wkhtmltopdf.sh

9. Check to see if it works once again: run

/usr/local/bin/wkhtmltopdf.sh http://www.google.com test.pdf


<!-- more -->

To start off, let's issue the **rails new** command to create a new rails application, and I'll be 
using some of my preferred defaults, such as using postgres as the database. (Rails 5 will make this
even easier by adding the "--api" option.)

```console
rails new app_name -d postgresql --skip-javascript --skip-test-unit
```

Next, add both the jsonapi-resources and rspec-rails gems to your Gemfile:

```ruby
gem 'jsonapi-resources'

group :development, :test do
  gem 'rspec-rails', '~> 3.0'
end
```

Then you can run bundle install to install the specified gems:

```console
bundle install
```

Install Rspec

```console
rails generate rspec:install
```console

Add API Inflection

```ruby
ActiveSupport::Inflector.inflections(:en) do |inflect|
  inflect.acronym 'API'
end
```


Edit config/environments/development.rb

Eager loading of classes is recommended. The code will work without it, but 
I think it's the right way to go. Also, turn off consider_all_request_local. 
This will prevent the server from returning the HTML formatted error messages 
when an exception happens.

```ruby
config.eager_load = true

config.consider_all_requests_local       = false
```


## Add Auction Model

```console
rails generate model Auction
```


## Add Auctions Model



## Setup RSpec

Add FactoryGirl to Gemfile

```ruby
gem 'factory_girl_rails'
```

## Versioning the API

It might seem premature to think about versioning when we're just getting started but I like
to set it up at the beginning. It allows me to set up my routes so that additional versions
can be added easily in the future and I don't need to change the existing routes. The nice
thing is to specify a default versions so that clients at this stage don't even need to worry
about specifying a version number.

/config/routes.rb

```ruby
namespace :api, path: '/' do
  scope module: :v1, constraints: ApiConstraints.new(version: 1, default: :true) do
    jsonapi_resources :auctions
  end
end
```

What that does is wrap up our routes in the API namespace but makes it accessible
from the root "/" url. We then set up a scope for each version, in this case we
only have v1, but in the future we can add additional scopes to support new versions.
We can also specify the default version. the ApiConstrants object handles
versioning through an Accept header. If any client wants a version other than the default
they just send an Accept header with their desired version.

/lib/api_constraints.rb

```ruby
class ApiConstraints
  def initialize(options)
    @version = options[:version]
    @default = options[:default]
  end

  def matches?(req)
    @default || req.headers['Accept'].include?("application/vnd.myapp.v#{@version}")
  end
end
```



## Add a Test for the /auctions Endpoint

spec/requests/auctions_spec.rb

```ruby
RSpec.describe "Auctions RESTful API" do
  describe "GET /auctions" do

    it "returns all the auctions" do
      FactoryGirl.create :auction, name: "General Auction"

      get "/auctions", {}, { "Accept" => "application/json" }

      expect(response.status).to eq 200

      body = JSON.parse(response.body)

      print body
      #auction_titles = body.map { |m| m["title"] }

      expect(body["data"][0]["name"]).to eq("General Auction")
    end
  end
end
```

Run the test to see it fail:

```console
rspec spec/requests/auctions_spec.rb
```

## Get test passing

